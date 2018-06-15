using System;
using System.Management.Automation;

namespace OPNsense.freeradius.client.clients {
	public class Client {
		#region Parameters
		public bool enabled { get; set; }
		public string ip { get; set; }
		public string name { get; set; }
		public string secret { get; set; }
		#endregion Parameters

		public Client () {
			enabled = true;
			ip = null;
			name = null;
			secret = null;
		}

		public Client (
			byte Enabled,
			string Ip,
			string Name,
			string Secret
		) {
			enabled = (Enabled == 0) ? false : true;
			ip = Ip;
			name = Name;
			secret = Secret;
		}
	}
}
namespace OPNsense.freeradius.user.users {
	public class User {
		#region Parameters
		public int chillispot_bw_max_down { get; set; }
		public int chillispot_bw_max_up { get; set; }
		public string description { get; set; }
		public bool enabled { get; set; }
		public string ip { get; set; }
		public PSObject ip6 { get; set; }
		public int mikrotik_vlan_id_number { get; set; }
		public int mikrotik_vlan_id_type { get; set; }
		public string password { get; set; }
		public Object route { get; set; }
		public int sessionlimit_max_session_limit { get; set; }
		public string subnet { get; set; }
		public string username { get; set; }
		public uint vlan { get; set; }
		public int wispr_bw_max_down { get; set; }
		public int wispr_bw_max_up { get; set; }
		public int wispr_bw_min_down { get; set; }
		public int wispr_bw_min_up { get; set; }
		#endregion Parameters

		public User () {
			chillispot_bw_max_down = 0;
			chillispot_bw_max_up = 0;
			description = null;
			enabled = true;
			ip = null;
			ip6 = null;
			mikrotik_vlan_id_number = 0;
			mikrotik_vlan_id_type = 0;
			password = null;
			route = null;
			sessionlimit_max_session_limit = 0;
			subnet = null;
			username = null;
			vlan = 0;
			wispr_bw_max_down = 0;
			wispr_bw_max_up = 0;
			wispr_bw_min_down = 0;
			wispr_bw_min_up = 0;
		}

		public User (
			int Chillispot_Bw_Max_Down,
			int Chillispot_Bw_Max_Up,
			string Description,
			byte Enabled,
			string Ip,
			PSObject Ip6,
			int Mikrotik_Vlan_Id_Number,
			int Mikrotik_Vlan_Id_Type,
			string Password,
			Object Route,
			int Sessionlimit_Max_Session_Limit,
			string Subnet,
			string Username,
			uint Vlan,
			int Wispr_Bw_Max_Down,
			int Wispr_Bw_Max_Up,
			int Wispr_Bw_Min_Down,
			int Wispr_Bw_Min_Up
		) {
			chillispot_bw_max_down = Chillispot_Bw_Max_Down;
			chillispot_bw_max_up = Chillispot_Bw_Max_Up;
			description = Description;
			enabled = (Enabled == 0) ? false : true;
			ip = Ip;
			ip6 = Ip6;
			mikrotik_vlan_id_number = Mikrotik_Vlan_Id_Number;
			mikrotik_vlan_id_type = Mikrotik_Vlan_Id_Type;
			password = Password;
			route = Route;
			sessionlimit_max_session_limit = Sessionlimit_Max_Session_Limit;
			subnet = Subnet;
			username = Username;
			vlan = Vlan;
			wispr_bw_max_down = Wispr_Bw_Max_Down;
			wispr_bw_max_up = Wispr_Bw_Max_Up;
			wispr_bw_min_down = Wispr_Bw_Min_Down;
			wispr_bw_min_up = Wispr_Bw_Min_Up;
		}
	}
}
