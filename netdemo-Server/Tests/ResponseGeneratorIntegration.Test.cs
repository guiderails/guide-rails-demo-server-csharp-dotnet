using System;
using System.Threading.Tasks;
using System.Net.Http;
using Xunit;

namespace Server.Integration.Tests {

	public class ResponseGeneratorIntegrationTest {

		readonly string url;

		public ResponseGeneratorIntegrationTest() {
			url = "http://localhost:8080/";
		}

		[Fact]
		[Trait("Category", "Integration")]
		void VerifyServerResponse() {
			HttpClientHandler handler = new HttpClientHandler();
			HttpClient httpClient = new HttpClient(handler);
			HttpResponseMessage response;
			response = httpClient.GetAsync(url).Result;
			Assert.True(response.IsSuccessStatusCode);
		}

	}
}
