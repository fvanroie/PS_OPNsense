using System;
using System.Management.Automation;

namespace OPNsense.wireguard.client.clients {
	public class Client {
		#region Parameters
		public bool enabled { get; set; }
		public string name { get; set; }
		public string psk { get; set; }
		public string pubkey { get; set; }
		public string serveraddress { get; set; }
		public ushort serverport { get; set; }
		public PSObject tunneladdress { get; set; }
		#endregion Parameters

		public Client () {
			enabled = true;
			name = null;
			psk = null;
			pubkey = null;
			serveraddress = null;
			serverport = null;
			tunneladdress = null;
		}

		public Client (
			byte Enabled,
			string Name,
			string Psk,
			string Pubkey,
			string Serveraddress,
			ushort Serverport,
			PSObject Tunneladdress
		) {
			enabled = (Enabled == 0) ? false : true;
			name = Name;
			psk = Psk;
			pubkey = Pubkey;
			serveraddress = Serveraddress;
			serverport = Serverport;
			tunneladdress = Tunneladdress;
		}
	}
}
namespace OPNsense.wireguard.server.servers {
	public class Server {
		#region Parameters
		public bool disableroutes { get; set; }
		public Object dns { get; set; }
		public bool enabled { get; set; }
		public int instance { get; set; }
		public string name { get; set; }
		public PSObject peers { get; set; }
		public ushort port { get; set; }
		public string privkey { get; set; }
		public string pubkey { get; set; }
		public PSObject tunneladdress { get; set; }
		#endregion Parameters

		public Server () {
			disableroutes = true;
			dns = null;
			enabled = true;
			instance = 0;
			name = null;
			peers = null;
			port = null;
			privkey = null;
			pubkey = null;
			tunneladdress = null;
		}

		public Server (
			byte Disableroutes,
			Object Dns,
			byte Enabled,
			int Instance,
			string Name,
			PSObject Peers,
			ushort Port,
			string Privkey,
			string Pubkey,
			PSObject Tunneladdress
		) {
			disableroutes = (Disableroutes == 0) ? false : true;
			dns = Dns;
			enabled = (Enabled == 0) ? false : true;
			instance = Instance;
			name = Name;
			peers = Peers;
			port = Port;
			privkey = Privkey;
			pubkey = Pubkey;
			tunneladdress = Tunneladdress;
		}
	}
}
namespace OPNsense.wireguard {
	public class General {
		#region Parameters
		public bool enabled { get; set; }
		#endregion Parameters

		public General () {
			enabled = true;
		}

		public General (
			byte Enabled
		) {
			enabled = (Enabled == 0) ? false : true;
		}
	}
}
