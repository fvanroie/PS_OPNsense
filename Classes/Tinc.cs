namespace OPNsense.Tinc {
	public class Host {
		#region Paramaters
		public System.Management.Automation.PSObject cipher { get; set; }
		public bool connectTo { get; set; }
		public bool enabled { get; set; }
		public string extaddress { get; set; }
		public int extport { get; set; }
		public string hostname { get; set; }
		public System.Management.Automation.PSObject network { get; set; }
		public string pubkey { get; set; }
		public System.Management.Automation.PSObject subnet { get; set; }
		#endregion Paramaters

		#region Constructors
		public Host() {
			cipher = null;
			connectTo = false;
			enabled = false;
			extaddress = null;
			extport = 0;
			hostname = null;
			network = null;
			pubkey = null;
			subnet = null;
		}

		public Host(
			System.Management.Automation.PSObject Cipher,
			bool ConnectTo,
			bool Enabled,
			string Extaddress,
			int Extport,
			string Hostname,
			System.Management.Automation.PSObject Network,
			string Pubkey,
			System.Management.Automation.PSObject Subnet
		) {
			cipher = Cipher;
			connectTo = ConnectTo;
			enabled = Enabled;
			extaddress = Extaddress;
			extport = Extport;
			hostname = Hostname;
			network = Network;
			pubkey = Pubkey;
			subnet = Subnet;
		}
		#endregion Constructors
	}
	public class Network {
		#region Paramaters
		public System.Management.Automation.PSObject cipher { get; set; }
		public System.Management.Automation.PSObject debuglevel { get; set; }
		public bool enabled { get; set; }
		public string extaddress { get; set; }
		public int extport { get; set; }
		public string hostname { get; set; }
		public int id { get; set; }
		public System.Management.Automation.PSObject intaddress { get; set; }
		public System.Management.Automation.PSObject mode { get; set; }
		public string name { get; set; }
		public int pingtimeout { get; set; }
		public bool PMTUDiscovery { get; set; }
		public string privkey { get; set; }
		public string pubkey { get; set; }
		public System.Management.Automation.PSObject subnet { get; set; }
		#endregion Paramaters

		#region Constructors
		public Network() {
			cipher = null;
			debuglevel = null;
			enabled = false;
			extaddress = null;
			extport = 0;
			hostname = null;
			id = 0;
			intaddress = null;
			mode = null;
			name = null;
			pingtimeout = 0;
			PMTUDiscovery = false;
			privkey = null;
			pubkey = null;
			subnet = null;
		}

		public Network(
			System.Management.Automation.PSObject Cipher,
			System.Management.Automation.PSObject Debuglevel,
			bool Enabled,
			string Extaddress,
			int Extport,
			string Hostname,
			int Id,
			System.Management.Automation.PSObject Intaddress,
			System.Management.Automation.PSObject Mode,
			string Name,
			int Pingtimeout,
			bool pmtudiscovery,
			string Privkey,
			string Pubkey,
			System.Management.Automation.PSObject Subnet
		) {
			cipher = Cipher;
			debuglevel = Debuglevel;
			enabled = Enabled;
			extaddress = Extaddress;
			extport = Extport;
			hostname = Hostname;
			id = Id;
			intaddress = Intaddress;
			mode = Mode;
			name = Name;
			pingtimeout = Pingtimeout;
			PMTUDiscovery = pmtudiscovery;
			privkey = Privkey;
			pubkey = Pubkey;
			subnet = Subnet;
		}
		#endregion Constructors
	}
}
