Param($ResourceGroupName, $Name)

# Get-ChildItem でファイルのリストを作ってパイプでCompress-Archiveします。
Get-ChildItem -Path * -Exclude @("node_modules","dist","app.zip") |  Compress-Archive -DestinationPath .\app.zip -CompressionLevel Fastest -Force

az webapp deployment source config-zip --resource-group $ResourceGroupName --name $Name --src .\app.zip