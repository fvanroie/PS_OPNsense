using System;
using System.Management.Automation;

namespace OPNsense.quagga.ospf.interfaces {
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
namespace OPNsense.quagga.ospf.networks {
	public class Network {
		#region Parameters
		public string area { get; set; }
		public bool enabled { get; set; }
		public string ipaddr { get; set; }
		public PSObject linkedPrefixlistIn { get; set; }
		public PSObject linkedPrefixlistOut { get; set; }
		public byte netmask { get; set; }
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
			byte Netmask
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
namespace OPNsense.quagga.ospf.prefixlists {
	public class Prefixlist {
		#region Parameters
		public PSObject action { get; set; }
		public bool enabled { get; set; }
		public string name { get; set; }
		public string network { get; set; }
		public byte seqnumber { get; set; }
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
			byte Seqnumber
		) {
			action = Action;
			enabled = (Enabled == 0) ? false : true;
			name = Name;
			network = Network;
			seqnumber = Seqnumber;
		}
	}
}
namespace OPNsense.quagga {
	public class Ospf {
		#region Parameters
		public bool enabled { get; set; }
		public bool originate { get; set; }
		public bool originatealways { get; set; }
		public PSObject passiveinterfaces { get; set; }
		public PSObject redistribute { get; set; }
		public string routerid { get; set; }
		#endregion Parameters

		public Ospf () {
			enabled = true;
			originate = true;
			originatealways = true;
			passiveinterfaces = null;
			redistribute = null;
			routerid = null;
		}

		public Ospf (
			byte Enabled,
			byte Originate,
			byte Originatealways,
			PSObject Passiveinterfaces,
			PSObject Redistribute,
			string Routerid
		) {
			enabled = (Enabled == 0) ? false : true;
			originate = (Originate == 0) ? false : true;
			originatealways = (Originatealways == 0) ? false : true;
			passiveinterfaces = Passiveinterfaces;
			redistribute = Redistribute;
			routerid = Routerid;
		}
	}
}
