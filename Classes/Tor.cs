using System;
using System.Management.Automation;

namespace OPNsense.tor.exitpolicy {
	public class Policy {
		#region Parameters
		public PSObject action { get; set; }
		public bool enabled { get; set; }
		public uint endport { get; set; }
		public PSObject network { get; set; }
		public uint startport { get; set; }
		public PSObject type { get; set; }
		#endregion Parameters

		public Policy () {
			action = null;
			enabled = true;
			endport = 0;
			network = null;
			startport = 0;
			type = null;
		}

		public Policy (
			PSObject Action,
			byte Enabled,
			uint Endport,
			PSObject Network,
			uint Startport,
			PSObject Type
		) {
			action = Action;
			enabled = (Enabled == 0) ? false : true;
			endport = Endport;
			network = Network;
			startport = Startport;
			type = Type;
		}
	}
}
namespace OPNsense.tor.hiddenservice {
	public class Service {
		#region Parameters
		public Object clients { get; set; }
		public bool enabled { get; set; }
		public string name { get; set; }
		public PSObject type { get; set; }
		#endregion Parameters

		public Service () {
			clients = null;
			enabled = true;
			name = null;
			type = null;
		}

		public Service (
			Object Clients,
			byte Enabled,
			string Name,
			PSObject Type
		) {
			clients = Clients;
			enabled = (Enabled == 0) ? false : true;
			name = Name;
			type = Type;
		}
	}
}
namespace OPNsense.tor.hiddenserviceacl {
	public class Hiddenserviceacl {
		#region Parameters
		public bool enabled { get; set; }
		public PSObject hiddenservice { get; set; }
		public uint port { get; set; }
		public PSObject target_host { get; set; }
		public uint target_port { get; set; }
		#endregion Parameters

		public Hiddenserviceacl () {
			enabled = true;
			hiddenservice = null;
			port = 80;
			target_host = null;
			target_port = 80;
		}

		public Hiddenserviceacl (
			byte Enabled,
			PSObject Hiddenservice,
			uint Port,
			PSObject Target_Host,
			uint Target_Port
		) {
			enabled = (Enabled == 0) ? false : true;
			hiddenservice = Hiddenservice;
			port = Port;
			target_host = Target_Host;
			target_port = Target_Port;
		}
	}
}
namespace OPNsense.tor.general.client_authentications {
	public class Client_Auth {
		#region Parameters
		public string auth_cookie { get; set; }
		public bool enabled { get; set; }
		public string onion_service { get; set; }
		#endregion Parameters

		public Client_Auth () {
			auth_cookie = "0000000000000000000000";
			enabled = true;
			onion_service = "exampleexample23.onion";
		}

		public Client_Auth (
			string Auth_Cookie,
			byte Enabled,
			string Onion_Service
		) {
			auth_cookie = Auth_Cookie;
			enabled = (Enabled == 0) ? false : true;
			onion_service = Onion_Service;
		}
	}
}
namespace OPNsense.tor.aclsockspolicy {
	public class Policy {
		#region Parameters
		public PSObject action { get; set; }
		public bool enabled { get; set; }
		public PSObject network { get; set; }
		public PSObject type { get; set; }
		#endregion Parameters

		public Policy () {
			action = null;
			enabled = true;
			network = null;
			type = null;
		}

		public Policy (
			PSObject Action,
			byte Enabled,
			PSObject Network,
			PSObject Type
		) {
			action = Action;
			enabled = (Enabled == 0) ? false : true;
			network = Network;
			type = Type;
		}
	}
}
