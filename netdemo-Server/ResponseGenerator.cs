using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SharedLib;

namespace Server {
	class ResponseGenerator {

		public string GetResponseString() {
			// string response = @"<html><body>{{message}}</body></html>";
			string response = @"Server says: {{message}}";
			var ro = new SharedLib.RegistryOperations();
			response = response.Replace("{{message}}", ro.GetMessage());
			return response;
		}
	}
}
