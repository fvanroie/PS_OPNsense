namespace OPNsense.Tor {
	public class Exitacl {
		#region Paramaters
		public System.Management.Automation.PSObject action { get; set; }
		public bool enabled { get; set; }
		public int endport { get; set; }
		public System.Management.Automation.PSObject network { get; set; }
		public int startport { get; set; }
		public System.Management.Automation.PSObject type { get; set; }
		#endregion Paramaters

		#region Constructors
		public Exitacl() {
			action = null;
			enabled = false;
			endport = 0;
			network = null;
			startport = 0;
			type = null;
		}

		public Exitacl(
			System.Management.Automation.PSObject Action,
			bool Enabled,
			int Endport,
			System.Management.Automation.PSObject Network,
			int Startport,
			System.Management.Automation.PSObject Type
		) {
			action = Action;
			enabled = Enabled;
			endport = Endport;
			network = Network;
			startport = Startport;
			type = Type;
		}
		#endregion Constructors
	}
	public class HiddenService {
		#region Paramaters
		public System.Object[] clients { get; set; }
		public bool enabled { get; set; }
		public string name { get; set; }
		public System.Management.Automation.PSObject type { get; set; }
		#endregion Paramaters

		#region Constructors
		public HiddenService() {
			clients = null;
			enabled = false;
			name = null;
			type = null;
		}

		public HiddenService(
			System.Object[] Clients,
			bool Enabled,
			string Name,
			System.Management.Automation.PSObject Type
		) {
			clients = Clients;
			enabled = Enabled;
			name = Name;
			type = Type;
		}
		#endregion Constructors
	}
	public class HiddenServiceACL {
		#region Paramaters
		public bool enabled { get; set; }
		public System.Management.Automation.PSObject hiddenservice { get; set; }
		public int port { get; set; }
		public System.Management.Automation.PSObject target_host { get; set; }
		public int target_port { get; set; }
		#endregion Paramaters

		#region Constructors
		public HiddenServiceACL() {
			enabled = false;
			hiddenservice = null;
			port = 0;
			target_host = null;
			target_port = 0;
		}

		public HiddenServiceACL(
			bool Enabled,
			System.Management.Automation.PSObject Hiddenservice,
			int Port,
			System.Management.Automation.PSObject Target_Host,
			int Target_Port
		) {
			enabled = Enabled;
			hiddenservice = Hiddenservice;
			port = Port;
			target_host = Target_Host;
			target_port = Target_Port;
		}
		#endregion Constructors
	}
	public class HiddenServiceAuth {
		#region Paramaters
		public string auth_cookie { get; set; }
		public bool enabled { get; set; }
		public string onion_service { get; set; }
		#endregion Paramaters

		#region Constructors
		public HiddenServiceAuth() {
			auth_cookie = null;
			enabled = false;
			onion_service = null;
		}

		public HiddenServiceAuth(
			string Auth_Cookie,
			bool Enabled,
			string Onion_Service
		) {
			auth_cookie = Auth_Cookie;
			enabled = Enabled;
			onion_service = Onion_Service;
		}
		#endregion Constructors
	}
	public class SocksACL {
		#region Paramaters
		public System.Management.Automation.PSObject action { get; set; }
		public bool enabled { get; set; }
		public System.Management.Automation.PSObject network { get; set; }
		public System.Management.Automation.PSObject type { get; set; }
		#endregion Paramaters

		#region Constructors
		public SocksACL() {
			action = null;
			enabled = false;
			network = null;
			type = null;
		}

		public SocksACL(
			System.Management.Automation.PSObject Action,
			bool Enabled,
			System.Management.Automation.PSObject Network,
			System.Management.Automation.PSObject Type
		) {
			action = Action;
			enabled = Enabled;
			network = Network;
			type = Type;
		}
		#endregion Constructors
	}
}
