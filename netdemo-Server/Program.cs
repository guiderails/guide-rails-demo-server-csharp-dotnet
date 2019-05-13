using System;
using System.Net;
using System.Threading;

namespace Server {
	class Program {

		private static HttpListener listener;

		static void Main(string[] args) {
			bool done = false;
			try {
				listener = new HttpListener();
				listener.Prefixes.Add("http://localhost:8080/");
				Console.WriteLine("Starting server on port 8080");
				listener.Start();
			} catch (Exception ex) {
				Console.WriteLine(ex.Message);
				done = true;
			}

			try {
				while (!done) {
					ThreadPool.QueueUserWorkItem(HandleRequest, listener.GetContext());
				}
			} catch (Exception ex) {
				Console.WriteLine(ex.Message);
			}
			Console.WriteLine("Exiting....");
		}

		private static void HandleRequest(object state) {
			HttpListenerContext context = state as HttpListenerContext;
			if (listener != null) {
				ResponseGenerator rg = new ResponseGenerator();
				HttpListenerResponse response = context.Response;
				response.StatusCode = 200;
				byte[] buffer = System.Text.Encoding.UTF8.GetBytes(rg.GetResponseString());
				response.ContentLength64 = buffer.Length;
				System.IO.Stream output = response.OutputStream;
				output.Write(buffer, 0, buffer.Length);
				output.Close();
			}
		}
	}
}
