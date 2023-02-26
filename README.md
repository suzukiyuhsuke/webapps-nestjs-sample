# Azure App Service で Nest.js をデプロイするためのサンプルプロジェクト
## 基本的なことの説明
1. Nest.js のインストールとサンプルプロジェクト作成
適当なディレクトリで、
```powershell
npm i -g @nestjs/cli
nest new webapps-nestjs-sample
```
2. **src/main.ts** で*listen port*の設定を書き換える。
```
import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';

const port = process.env.PORT || 3000; 

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  await app.listen(port);
}
bootstrap();
```
> 参考:[Azure App Service 向けの Node.js アプリを構成する](https://learn.microsoft.com/azure/app-service/configure-language-nodejs?pivots=platform-linux#get-port-number)

3. **packages.json**の*"start"*の内容を以下のように書き換える。
```
    "start": "node dist/main",
```
> 元は`nest start`となっているが、そのままではApp Serviceでアプリが起動する際に失敗する為

4. ローカルPC（Windows）側にAzure CLIをインストールする。
- winget を使った例
```powershell
winget install -e --id Microsoft.AzureCLI
```
> 参考:[WindowsでのAzure CLIのインストール](https://learn.microsoft.com/ja-jp/cli/azure/install-azure-cli-windows?tabs=winget)

5. deploy.sh を実行する（App Serviceのリソースは適当に作るものとする）
- 必要に応じて
```powershell
Set-ExecutionPolicy -Scope CurrentUser Unrestricted
```
- deploy.shの実行
```powershell -ResourceGroupName <resource-group-name> -Name <appservice-name>
deploy.sh
```
> `<resource-group-name>`にはリソースグループ名、`<appservice-name>`には対象のApp Serviceのリソース名を入れて実行

> 動確しているのはLinuxのFree