namespace OPNsense.FreeRadius {
	public class Client {
		#region Paramaters
		public bool enabled { get; set; }
		public string ip { get; set; }
		public string name { get; set; }
		public string secret { get; set; }
		#endregion Paramaters

		#region Constructors
		public Client() {
			enabled = false;
			ip = null;
			name = null;
			secret = null;
		}

		public Client(
			bool Enabled,
			string Ip,
			string Name,
			string Secret
		) {
			enabled = Enabled;
			ip = Ip;
			name = Name;
			secret = Secret;
		}
		#endregion Constructors
	}
	public class User {
		#region Paramaters
		public int chillispot_bw_max_down { get; set; }
		public int chillispot_bw_max_up { get; set; }
		public string description { get; set; }
		public bool enabled { get; set; }
		public string ip { get; set; }
		public string password { get; set; }
		public int sessionlimit_max_session_limit { get; set; }
		public string subnet { get; set; }
		public string username { get; set; }
		public int vlan { get; set; }
		public int wispr_bw_max_down { get; set; }
		public int wispr_bw_max_up { get; set; }
		public int wispr_bw_min_down { get; set; }
		public int wispr_bw_min_up { get; set; }
		#endregion Paramaters

		#region Constructors
		public User() {
			chillispot_bw_max_down = 0;
			chillispot_bw_max_up = 0;
			description = null;
			enabled = false;
			ip = null;
			password = null;
			sessionlimit_max_session_limit = 0;
			subnet = null;
			username = null;
			vlan = 0;
			wispr_bw_max_down = 0;
			wispr_bw_max_up = 0;
			wispr_bw_min_down = 0;
			wispr_bw_min_up = 0;
		}

		public User(
			int Chillispot_Bw_Max_Down,
			int Chillispot_Bw_Max_Up,
			string Description,
			bool Enabled,
			string Ip,
			string Password,
			int Sessionlimit_Max_Session_Limit,
			string Subnet,
			string Username,
			int Vlan,
			int Wispr_Bw_Max_Down,
			int Wispr_Bw_Max_Up,
			int Wispr_Bw_Min_Down,
			int Wispr_Bw_Min_Up
		) {
			chillispot_bw_max_down = Chillispot_Bw_Max_Down;
			chillispot_bw_max_up = Chillispot_Bw_Max_Up;
			description = Description;
			enabled = Enabled;
			ip = Ip;
			password = Password;
			sessionlimit_max_session_limit = Sessionlimit_Max_Session_Limit;
			subnet = Subnet;
			username = Username;
			vlan = Vlan;
			wispr_bw_max_down = Wispr_Bw_Max_Down;
			wispr_bw_max_up = Wispr_Bw_Max_Up;
			wispr_bw_min_down = Wispr_Bw_Min_Down;
			wispr_bw_min_up = Wispr_Bw_Min_Up;
		}
		#endregion Constructors
	}
}
