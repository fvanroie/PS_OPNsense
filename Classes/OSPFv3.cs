using System;
using System.Management.Automation;

namespace OPNsense.quagga.ospf6.interfaces {
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
namespace OPNsense.quagga {
	public class Ospf6 {
		#region Parameters
		public bool enabled { get; set; }
		public PSObject redistribute { get; set; }
		public string routerid { get; set; }
		#endregion Parameters

		public Ospf6 () {
			enabled = true;
			redistribute = null;
			routerid = null;
		}

		public Ospf6 (
			byte Enabled,
			PSObject Redistribute,
			string Routerid
		) {
			enabled = (Enabled == 0) ? false : true;
			redistribute = Redistribute;
			routerid = Routerid;
		}
	}
}
