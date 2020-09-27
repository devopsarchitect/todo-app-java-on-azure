Quickstart: Create an Azure Cognitive Search index in PowerShell using REST APIs

Connect to Azure Cognitive Search
In PowerShell, create a $headers object to store the content-type and API key. Replace the admin API key (YOUR-ADMIN-API-KEY) with a key that is valid for your search service. You only have to set this header once for the duration of the session, but you will add it to every request.

PowerShell

Copy
$headers = @{
'api-key' = '<YOUR-ADMIN-API-KEY>'
'Content-Type' = 'application/json' 
'Accept' = 'application/json' }
Create a $url object that specifies the service's indexes collection. Replace the service name (YOUR-SEARCH-SERVICE-NAME) with a valid search service.

PowerShell

Copy
$url = "https://<YOUR-SEARCH-SERVICE-NAME>.search.windows.net/indexes?api-version=2020-06-30&$select=name"
Run Invoke-RestMethod to send a GET request to the service and verify the connection. Add ConvertTo-Json so that you can view the responses sent back from the service.

PowerShell

Copy
Invoke-RestMethod -Uri $url -Headers $headers | ConvertTo-Json
If the service is empty and has no indexes, results are similar to the following example. Otherwise, you'll see a JSON representation of index definitions.


Copy
{
    "@odata.context":  "https://mydemo.search.windows.net/$metadata#indexes",
    "value":  [

            ]
}