
using System.IO;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.AspNetCore.Http;
using Microsoft.Azure.WebJobs.Host;
using Newtonsoft.Json;
using Dapper;
using System.Data.SqlClient;
using System.Collections.Generic;
using System;

namespace DataReturnFunctions
{
    public static class GetGroup
    {
        [FunctionName("GetGroup")]
        public static IActionResult Run([HttpTrigger(AuthorizationLevel.Function, "get", "post", Route = null)]HttpRequest req, TraceWriter log)
        {
            log.Info("C# HTTP trigger function processed a request.");

            string groupID = req.Query["GroupID"];

            string requestBody = new StreamReader(req.Body).ReadToEnd();
            dynamic data = JsonConvert.DeserializeObject(requestBody);
            groupID = groupID ?? data?.GroupID;
            List<string> resultString = new List<string>();

            string querySelect = "SELECT GroupID, GroupName, GroupPassword, CreateDate FROM BORTT.dbo.[Group] (nolock) WHERE GroupID = @GroupID";
            using (var connection = new SqlConnection("Data Source=Server = tcp:bortt.database.windows.net,1433; Initial Catalog = BORTT; Persist Security Info = False; User ID = acsmithadmin; Password = Idontknow1; MultipleActiveResultSets = False; Encrypt = True; TrustServerCertificate = False; Connection Timeout = 30;"))
            {
                var test = connection.Query<Group>(querySelect, new { GroupID = groupID });
                foreach (var rowz in test)
                {
                    resultString.Add(rowz.toString());
                }
            }


                if (!string.IsNullOrEmpty(groupID))
                {
                    return new OkObjectResult($"Success: {groupID}\r\n{resultString}");
                }
                else return new BadRequestObjectResult("It's borked");
        }
    }

    public class Group
    {
        int GroupID { get; set; }
        string GroupName { get; set; }
        string GroupPassword { get; set; }
        DateTime CreateDate { get; set; }
        public string toString()
        {
            return $"ID: {GroupID} | Name: {GroupName} | Password: {GroupPassword} | Created: {CreateDate}";
        }
    }
}
