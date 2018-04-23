using System;
using System.Management.Automation;

namespace OPNsense.Tor {
	public class Exitacl {
		#region Parameters
		public PSObject action { get; set; }
		public bool enabled { get; set; }
		public int endport { get; set; }
		public PSObject network { get; set; }
		public int startport { get; set; }
		public PSObject type { get; set; }
		#endregion Parameters

		public Exitacl () {
			action = null;
			enabled = false;
			endport = 0;
			network = null;
			startport = 0;
			type = null;
		}

		public Exitacl (
			PSObject Action,
			bool Enabled,
			int Endport,
			PSObject Network,
			int Startport,
			PSObject Type
		) {
			action = Action;
			enabled = Enabled;
			endport = Endport;
			network = Network;
			startport = Startport;
			type = Type;
		}
	}
	public class HiddenService {
		#region Parameters
		public Object clients { get; set; }
		public bool enabled { get; set; }
		public string name { get; set; }
		public PSObject type { get; set; }
		#endregion Parameters

		public HiddenService () {
			clients = null;
			enabled = false;
			name = null;
			type = null;
		}

		public HiddenService (
			Object Clients,
			bool Enabled,
			string Name,
			PSObject Type
		) {
			clients = Clients;
			enabled = Enabled;
			name = Name;
			type = Type;
		}
	}
	public class HiddenServiceACL {
		#region Parameters
		public bool enabled { get; set; }
		public PSObject hiddenservice { get; set; }
		public int port { get; set; }
		public PSObject target_host { get; set; }
		public int target_port { get; set; }
		#endregion Parameters

		public HiddenServiceACL () {
			enabled = false;
			hiddenservice = null;
			port = 0;
			target_host = null;
			target_port = 0;
		}

		public HiddenServiceACL (
			bool Enabled,
			PSObject Hiddenservice,
			int Port,
			PSObject Target_Host,
			int Target_Port
		) {
			enabled = Enabled;
			hiddenservice = Hiddenservice;
			port = Port;
			target_host = Target_Host;
			target_port = Target_Port;
		}
	}
	public class HiddenServiceAuth {
		#region Parameters
		public string auth_cookie { get; set; }
		public bool enabled { get; set; }
		public string onion_service { get; set; }
		#endregion Parameters

		public HiddenServiceAuth () {
			auth_cookie = null;
			enabled = false;
			onion_service = null;
		}

		public HiddenServiceAuth (
			string Auth_Cookie,
			bool Enabled,
			string Onion_Service
		) {
			auth_cookie = Auth_Cookie;
			enabled = Enabled;
			onion_service = Onion_Service;
		}
	}
	public class SocksACL {
		#region Parameters
		public PSObject action { get; set; }
		public bool enabled { get; set; }
		public PSObject network { get; set; }
		public PSObject type { get; set; }
		#endregion Parameters

		public SocksACL () {
			action = null;
			enabled = false;
			network = null;
			type = null;
		}

		public SocksACL (
			PSObject Action,
			bool Enabled,
			PSObject Network,
			PSObject Type
		) {
			action = Action;
			enabled = Enabled;
			network = Network;
			type = Type;
		}
	}
}
