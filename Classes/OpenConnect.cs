using System;
using System.Management.Automation;

namespace OPNsense.openconnect {
	public class General {
		#region Parameters
		public  clientcertificate { get; set; }
		public bool enabled { get; set; }
		public string group { get; set; }
		public PSObject hash { get; set; }
		public string password { get; set; }
		public string server { get; set; }
		public string servercert { get; set; }
		public string user { get; set; }
		#endregion Parameters

		public General () {
			clientcertificate = ;
			enabled = true;
			group = null;
			hash = null;
			password = "password";
			server = "server";
			servercert = null;
			user = "user";
		}

		public General (
			 Clientcertificate,
			byte Enabled,
			string Group,
			PSObject Hash,
			string Password,
			string Server,
			string Servercert,
			string User
		) {
			clientcertificate = Clientcertificate;
			enabled = (Enabled == 0) ? false : true;
			group = Group;
			hash = Hash;
			password = Password;
			server = Server;
			servercert = Servercert;
			user = User;
		}
	}
}
