using System;
using System.Management.Automation;

namespace OPNsense.Quagga.BGP {
	public class AsPath {
		#region Parameters
		public PSObject action { get; set; }
		public string AS { get; set; }
		public bool enabled { get; set; }
		public uint number { get; set; }
		#endregion Parameters

		public AsPath () {
			action = null;
			AS = null;
			enabled = true;
			number = 0;
		}

		public AsPath (
			PSObject Action,
			string AS_,
			byte Enabled,
			uint Number
		) {
			action = Action;
			AS = AS_;
			enabled = (Enabled == 0) ? false : true;
			number = Number;
		}
	}
}
namespace OPNsense.Quagga.BGP {
	public class Neighbor {
		#region Parameters
		public string address { get; set; }
		public bool defaultoriginate { get; set; }
		public bool enabled { get; set; }
		public PSObject linkedPrefixlistIn { get; set; }
		public PSObject linkedPrefixlistOut { get; set; }
		public PSObject linkedRoutemapIn { get; set; }
		public PSObject linkedRoutemapOut { get; set; }
		public bool nexthopself { get; set; }
		public uint remoteas { get; set; }
		public PSObject updatesource { get; set; }
		#endregion Parameters

		public Neighbor () {
			address = null;
			defaultoriginate = true;
			enabled = true;
			linkedPrefixlistIn = null;
			linkedPrefixlistOut = null;
			linkedRoutemapIn = null;
			linkedRoutemapOut = null;
			nexthopself = true;
			remoteas = 0;
			updatesource = null;
		}

		public Neighbor (
			string Address,
			byte Defaultoriginate,
			byte Enabled,
			PSObject LinkedPrefixlistIn,
			PSObject LinkedPrefixlistOut,
			PSObject LinkedRoutemapIn,
			PSObject LinkedRoutemapOut,
			byte Nexthopself,
			uint Remoteas,
			PSObject Updatesource
		) {
			address = Address;
			defaultoriginate = (Defaultoriginate == 0) ? false : true;
			enabled = (Enabled == 0) ? false : true;
			linkedPrefixlistIn = LinkedPrefixlistIn;
			linkedPrefixlistOut = LinkedPrefixlistOut;
			linkedRoutemapIn = LinkedRoutemapIn;
			linkedRoutemapOut = LinkedRoutemapOut;
			nexthopself = (Nexthopself == 0) ? false : true;
			remoteas = Remoteas;
			updatesource = Updatesource;
		}
	}
}
namespace OPNsense.Quagga.BGP {
	public class Prefixlist {
		#region Parameters
		public PSObject action { get; set; }
		public bool enabled { get; set; }
		public string name { get; set; }
		public string network { get; set; }
		public uint seqnumber { get; set; }
		#endregion Parameters

		public Prefixlist () {
			action = null;
			enabled = true;
			name = null;
			network = null;
			seqnumber = 0;
		}

		public Prefixlist (
			PSObject Action,
			byte Enabled,
			string Name,
			string Network,
			uint Seqnumber
		) {
			action = Action;
			enabled = (Enabled == 0) ? false : true;
			name = Name;
			network = Network;
			seqnumber = Seqnumber;
		}
	}
}
namespace OPNsense.Quagga.BGP {
	public class Routemap {
		#region Parameters
		public PSObject action { get; set; }
		public bool enabled { get; set; }
		public uint id { get; set; }
		public PSObject match { get; set; }
		public string name { get; set; }
		public string set { get; set; }
		#endregion Parameters

		public Routemap () {
			action = null;
			enabled = true;
			id = 0;
			match = null;
			name = null;
			set = null;
		}

		public Routemap (
			PSObject Action,
			byte Enabled,
			uint Id,
			PSObject Match,
			string Name,
			string Set
		) {
			action = Action;
			enabled = (Enabled == 0) ? false : true;
			id = Id;
			match = Match;
			name = Name;
			set = Set;
		}
	}
}
namespace OPNsense.Quagga.Ospf6 {
	public class Interface {
		#region Parameters
		public string area { get; set; }
		public uint cost { get; set; }
		public uint deadinterval { get; set; }
		public bool enabled { get; set; }
		public uint hellointerval { get; set; }
		public PSObject interfacename { get; set; }
		public PSObject networktype { get; set; }
		public uint priority { get; set; }
		public uint retransmitinterval { get; set; }
		public uint transmitdelay { get; set; }
		#endregion Parameters

		public Interface () {
			area = null;
			cost = 0;
			deadinterval = 0;
			enabled = true;
			hellointerval = 0;
			interfacename = null;
			networktype = null;
			priority = 0;
			retransmitinterval = 0;
			transmitdelay = 0;
		}

		public Interface (
			string Area,
			uint Cost,
			uint Deadinterval,
			byte Enabled,
			uint Hellointerval,
			PSObject Interfacename,
			PSObject Networktype,
			uint Priority,
			uint Retransmitinterval,
			uint Transmitdelay
		) {
			area = Area;
			cost = Cost;
			deadinterval = Deadinterval;
			enabled = (Enabled == 0) ? false : true;
			hellointerval = Hellointerval;
			interfacename = Interfacename;
			networktype = Networktype;
			priority = Priority;
			retransmitinterval = Retransmitinterval;
			transmitdelay = Transmitdelay;
		}
	}
}
namespace OPNsense.Quagga.Ospf {
	public class Interface {
		#region Parameters
		public string authkey { get; set; }
		public PSObject authtype { get; set; }
		public uint cost { get; set; }
		public uint deadinterval { get; set; }
		public bool enabled { get; set; }
		public uint hellointerval { get; set; }
		public PSObject interfacename { get; set; }
		public PSObject networktype { get; set; }
		public uint priority { get; set; }
		public uint retransmitinterval { get; set; }
		public uint transmitdelay { get; set; }
		#endregion Parameters

		public Interface () {
			authkey = null;
			authtype = null;
			cost = 0;
			deadinterval = 0;
			enabled = true;
			hellointerval = 0;
			interfacename = null;
			networktype = null;
			priority = 0;
			retransmitinterval = 0;
			transmitdelay = 0;
		}

		public Interface (
			string Authkey,
			PSObject Authtype,
			uint Cost,
			uint Deadinterval,
			byte Enabled,
			uint Hellointerval,
			PSObject Interfacename,
			PSObject Networktype,
			uint Priority,
			uint Retransmitinterval,
			uint Transmitdelay
		) {
			authkey = Authkey;
			authtype = Authtype;
			cost = Cost;
			deadinterval = Deadinterval;
			enabled = (Enabled == 0) ? false : true;
			hellointerval = Hellointerval;
			interfacename = Interfacename;
			networktype = Networktype;
			priority = Priority;
			retransmitinterval = Retransmitinterval;
			transmitdelay = Transmitdelay;
		}
	}
}
namespace OPNsense.Quagga.Ospf {
	public class Network {
		#region Parameters
		public string area { get; set; }
		public bool enabled { get; set; }
		public string ipaddr { get; set; }
		public PSObject linkedPrefixlistIn { get; set; }
		public PSObject linkedPrefixlistOut { get; set; }
		public uint netmask { get; set; }
		#endregion Parameters

		public Network () {
			area = null;
			enabled = true;
			ipaddr = null;
			linkedPrefixlistIn = null;
			linkedPrefixlistOut = null;
			netmask = 24;
		}

		public Network (
			string Area,
			byte Enabled,
			string Ipaddr,
			PSObject LinkedPrefixlistIn,
			PSObject LinkedPrefixlistOut,
			uint Netmask
		) {
			area = Area;
			enabled = (Enabled == 0) ? false : true;
			ipaddr = Ipaddr;
			linkedPrefixlistIn = LinkedPrefixlistIn;
			linkedPrefixlistOut = LinkedPrefixlistOut;
			netmask = Netmask;
		}
	}
}
namespace OPNsense.Quagga.Ospf {
	public class Prefixlist {
		#region Parameters
		public PSObject action { get; set; }
		public bool enabled { get; set; }
		public string name { get; set; }
		public string network { get; set; }
		public uint seqnumber { get; set; }
		#endregion Parameters

		public Prefixlist () {
			action = null;
			enabled = true;
			name = null;
			network = null;
			seqnumber = 0;
		}

		public Prefixlist (
			PSObject Action,
			byte Enabled,
			string Name,
			string Network,
			uint Seqnumber
		) {
			action = Action;
			enabled = (Enabled == 0) ? false : true;
			name = Name;
			network = Network;
			seqnumber = Seqnumber;
		}
	}
}
