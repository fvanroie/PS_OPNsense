using System;
using System.Management.Automation;

namespace OPNsense.siproxd.domain.domains {
	public class Domain {
		#region Parameters
		public bool enabled { get; set; }
		public string host { get; set; }
		public string name { get; set; }
		public int port { get; set; }
		#endregion Parameters

		public Domain () {
			enabled = true;
			host = null;
			name = null;
			port = 5060;
		}

		public Domain (
			byte Enabled,
			string Host,
			string Name,
			int Port
		) {
			enabled = (Enabled == 0) ? false : true;
			host = Host;
			name = Name;
			port = Port;
		}
	}
}
namespace OPNsense.siproxd.user.users {
	public class User {
		#region Parameters
		public bool enabled { get; set; }
		public string password { get; set; }
		public string username { get; set; }
		#endregion Parameters

		public User () {
			enabled = true;
			password = null;
			username = null;
		}

		public User (
			byte Enabled,
			string Password,
			string Username
		) {
			enabled = (Enabled == 0) ? false : true;
			password = Password;
			username = Username;
		}
	}
}
