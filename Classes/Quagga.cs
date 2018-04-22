namespace OPNsense.Quagga {
	public class BGPAspath {
		#region Paramaters
		public System.Management.Automation.PSObject action { get; set; }
		public string AS { get; set; }
		public bool enabled { get; set; }
		public int number { get; set; }
		#endregion Paramaters

		#region Constructors
		public BGPAspath() {
			action = null;
			AS = null;
			enabled = false;
			number = 0;
		}

		public BGPAspath(
			System.Management.Automation.PSObject Action,
			string AS_,
			bool Enabled,
			int Number
		) {
			action = Action;
			AS = AS_;
			enabled = Enabled;
			number = Number;
		}
		#endregion Constructors
	}
	public class BGPNeighbor {
		#region Paramaters
		public string address { get; set; }
		public bool defaultoriginate { get; set; }
		public bool enabled { get; set; }
		public System.Management.Automation.PSObject linkedPrefixlistIn { get; set; }
		public System.Management.Automation.PSObject linkedPrefixlistOut { get; set; }
		public System.Management.Automation.PSObject linkedRoutemapIn { get; set; }
		public System.Management.Automation.PSObject linkedRoutemapOut { get; set; }
		public bool nexthopself { get; set; }
		public int remoteas { get; set; }
		public System.Management.Automation.PSObject updatesource { get; set; }
		#endregion Paramaters

		#region Constructors
		public BGPNeighbor() {
			address = null;
			defaultoriginate = false;
			enabled = false;
			linkedPrefixlistIn = null;
			linkedPrefixlistOut = null;
			linkedRoutemapIn = null;
			linkedRoutemapOut = null;
			nexthopself = false;
			remoteas = 0;
			updatesource = null;
		}

		public BGPNeighbor(
			string Address,
			bool Defaultoriginate,
			bool Enabled,
			System.Management.Automation.PSObject LinkedPrefixlistIn,
			System.Management.Automation.PSObject LinkedPrefixlistOut,
			System.Management.Automation.PSObject LinkedRoutemapIn,
			System.Management.Automation.PSObject LinkedRoutemapOut,
			bool Nexthopself,
			int Remoteas,
			System.Management.Automation.PSObject Updatesource
		) {
			address = Address;
			defaultoriginate = Defaultoriginate;
			enabled = Enabled;
			linkedPrefixlistIn = LinkedPrefixlistIn;
			linkedPrefixlistOut = LinkedPrefixlistOut;
			linkedRoutemapIn = LinkedRoutemapIn;
			linkedRoutemapOut = LinkedRoutemapOut;
			nexthopself = Nexthopself;
			remoteas = Remoteas;
			updatesource = Updatesource;
		}
		#endregion Constructors
	}
	public class BGPPrefixlist {
		#region Paramaters
		public System.Management.Automation.PSObject action { get; set; }
		public bool enabled { get; set; }
		public string name { get; set; }
		public string network { get; set; }
		public int seqnumber { get; set; }
		#endregion Paramaters

		#region Constructors
		public BGPPrefixlist() {
			action = null;
			enabled = false;
			name = null;
			network = null;
			seqnumber = 0;
		}

		public BGPPrefixlist(
			System.Management.Automation.PSObject Action,
			bool Enabled,
			string Name,
			string Network,
			int Seqnumber
		) {
			action = Action;
			enabled = Enabled;
			name = Name;
			network = Network;
			seqnumber = Seqnumber;
		}
		#endregion Constructors
	}
	public class BGPRoutemap {
		#region Paramaters
		public System.Management.Automation.PSObject action { get; set; }
		public bool enabled { get; set; }
		public int id { get; set; }
		public System.Management.Automation.PSObject match { get; set; }
		public string name { get; set; }
		public string set { get; set; }
		#endregion Paramaters

		#region Constructors
		public BGPRoutemap() {
			action = null;
			enabled = false;
			id = 0;
			match = null;
			name = null;
			set = null;
		}

		public BGPRoutemap(
			System.Management.Automation.PSObject Action,
			bool Enabled,
			int Id,
			System.Management.Automation.PSObject Match,
			string Name,
			string Set
		) {
			action = Action;
			enabled = Enabled;
			id = Id;
			match = Match;
			name = Name;
			set = Set;
		}
		#endregion Constructors
	}
	public class Ospf6Interface {
		#region Paramaters
		public string area { get; set; }
		public int cost { get; set; }
		public int deadinterval { get; set; }
		public bool enabled { get; set; }
		public int hellointerval { get; set; }
		public System.Management.Automation.PSObject interfacename { get; set; }
		public System.Management.Automation.PSObject networktype { get; set; }
		public int priority { get; set; }
		public int retransmitinterval { get; set; }
		public int transmitdelay { get; set; }
		#endregion Paramaters

		#region Constructors
		public Ospf6Interface() {
			area = null;
			cost = 0;
			deadinterval = 0;
			enabled = false;
			hellointerval = 0;
			interfacename = null;
			networktype = null;
			priority = 0;
			retransmitinterval = 0;
			transmitdelay = 0;
		}

		public Ospf6Interface(
			string Area,
			int Cost,
			int Deadinterval,
			bool Enabled,
			int Hellointerval,
			System.Management.Automation.PSObject Interfacename,
			System.Management.Automation.PSObject Networktype,
			int Priority,
			int Retransmitinterval,
			int Transmitdelay
		) {
			area = Area;
			cost = Cost;
			deadinterval = Deadinterval;
			enabled = Enabled;
			hellointerval = Hellointerval;
			interfacename = Interfacename;
			networktype = Networktype;
			priority = Priority;
			retransmitinterval = Retransmitinterval;
			transmitdelay = Transmitdelay;
		}
		#endregion Constructors
	}
	public class OspfInterface {
		#region Paramaters
		public string authkey { get; set; }
		public System.Management.Automation.PSObject authtype { get; set; }
		public int cost { get; set; }
		public int deadinterval { get; set; }
		public bool enabled { get; set; }
		public int hellointerval { get; set; }
		public System.Management.Automation.PSObject interfacename { get; set; }
		public System.Management.Automation.PSObject networktype { get; set; }
		public int priority { get; set; }
		public int retransmitinterval { get; set; }
		public int transmitdelay { get; set; }
		#endregion Paramaters

		#region Constructors
		public OspfInterface() {
			authkey = null;
			authtype = null;
			cost = 0;
			deadinterval = 0;
			enabled = false;
			hellointerval = 0;
			interfacename = null;
			networktype = null;
			priority = 0;
			retransmitinterval = 0;
			transmitdelay = 0;
		}

		public OspfInterface(
			string Authkey,
			System.Management.Automation.PSObject Authtype,
			int Cost,
			int Deadinterval,
			bool Enabled,
			int Hellointerval,
			System.Management.Automation.PSObject Interfacename,
			System.Management.Automation.PSObject Networktype,
			int Priority,
			int Retransmitinterval,
			int Transmitdelay
		) {
			authkey = Authkey;
			authtype = Authtype;
			cost = Cost;
			deadinterval = Deadinterval;
			enabled = Enabled;
			hellointerval = Hellointerval;
			interfacename = Interfacename;
			networktype = Networktype;
			priority = Priority;
			retransmitinterval = Retransmitinterval;
			transmitdelay = Transmitdelay;
		}
		#endregion Constructors
	}
	public class OspfNetwork {
		#region Paramaters
		public string area { get; set; }
		public bool enabled { get; set; }
		public string ipaddr { get; set; }
		public System.Management.Automation.PSObject linkedPrefixlistIn { get; set; }
		public System.Management.Automation.PSObject linkedPrefixlistOut { get; set; }
		public int netmask { get; set; }
		#endregion Paramaters

		#region Constructors
		public OspfNetwork() {
			area = null;
			enabled = false;
			ipaddr = null;
			linkedPrefixlistIn = null;
			linkedPrefixlistOut = null;
			netmask = 0;
		}

		public OspfNetwork(
			string Area,
			bool Enabled,
			string Ipaddr,
			System.Management.Automation.PSObject LinkedPrefixlistIn,
			System.Management.Automation.PSObject LinkedPrefixlistOut,
			int Netmask
		) {
			area = Area;
			enabled = Enabled;
			ipaddr = Ipaddr;
			linkedPrefixlistIn = LinkedPrefixlistIn;
			linkedPrefixlistOut = LinkedPrefixlistOut;
			netmask = Netmask;
		}
		#endregion Constructors
	}
	public class OspfPrefixlist {
		#region Paramaters
		public System.Management.Automation.PSObject action { get; set; }
		public bool enabled { get; set; }
		public string name { get; set; }
		public string network { get; set; }
		public int seqnumber { get; set; }
		#endregion Paramaters

		#region Constructors
		public OspfPrefixlist() {
			action = null;
			enabled = false;
			name = null;
			network = null;
			seqnumber = 0;
		}

		public OspfPrefixlist(
			System.Management.Automation.PSObject Action,
			bool Enabled,
			string Name,
			string Network,
			int Seqnumber
		) {
			action = Action;
			enabled = Enabled;
			name = Name;
			network = Network;
			seqnumber = Seqnumber;
		}
		#endregion Constructors
	}
}
