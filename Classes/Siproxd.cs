namespace OPNsense.Siproxd {
	public class Domain {
		#region Paramaters
		public bool enabled { get; set; }
		public string host { get; set; }
		public string name { get; set; }
		public int port { get; set; }
		#endregion Paramaters

		#region Constructors
		public Domain() {
			enabled = false;
			host = null;
			name = null;
			port = 0;
		}

		public Domain(
			bool Enabled,
			string Host,
			string Name,
			int Port
		) {
			enabled = Enabled;
			host = Host;
			name = Name;
			port = Port;
		}
		#endregion Constructors
	}
	public class User {
		#region Paramaters
		public bool enabled { get; set; }
		public string password { get; set; }
		public string username { get; set; }
		#endregion Paramaters

		#region Constructors
		public User() {
			enabled = false;
			password = null;
			username = null;
		}

		public User(
			bool Enabled,
			string Password,
			string Username
		) {
			enabled = Enabled;
			password = Password;
			username = Username;
		}
		#endregion Constructors
	}
}
