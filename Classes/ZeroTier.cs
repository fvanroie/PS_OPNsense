using System;
using System.Management.Automation;

namespace OPNsense.Zerotier {
	public class Network {
		#region Parameters
		public string description { get; set; }
		public bool enabled { get; set; }
		public string networkId { get; set; }
		#endregion Parameters

		public Network () {
			description = null;
			enabled = true;
			networkId = null;
		}

		public Network (
			string Description,
			bool Enabled,
			string NetworkId
		) {
			description = Description;
			enabled = Enabled;
			networkId = NetworkId;
		}
	}
}
