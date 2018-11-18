using System;
using System.Management.Automation;

namespace OPNsense.zerotier.networks {
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
			byte Enabled,
			string NetworkId
		) {
			description = Description;
			enabled = (Enabled == 0) ? false : true;
			networkId = NetworkId;
		}
	}
}
namespace OPNsense {
	public class Zerotier {
		#region Parameters
		public string apiAccessToken { get; set; }
		public bool enabled { get; set; }
		public string localconf { get; set; }
		#endregion Parameters

		public Zerotier () {
			apiAccessToken = null;
			enabled = true;
			localconf = null;
		}

		public Zerotier (
			string ApiAccessToken,
			byte Enabled,
			string Localconf
		) {
			apiAccessToken = ApiAccessToken;
			enabled = (Enabled == 0) ? false : true;
			localconf = Localconf;
		}
	}
}
