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
		public string logintime { get; set; }
		public int mikrotik_vlan_id_number { get; set; }
		public int mikrotik_vlan_id_type { get; set; }
		public string password { get; set; }
		public Object route { get; set; }
		public int sessionlimit_max_session_limit { get; set; }
		public ushort simuse { get; set; }
		public string subnet { get; set; }
		public string username { get; set; }
		public ushort vlan { get; set; }
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
			logintime = null;
			mikrotik_vlan_id_number = 0;
			mikrotik_vlan_id_type = 0;
			password = null;
			route = null;
			sessionlimit_max_session_limit = 0;
			simuse = 0;
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
			string Logintime,
			int Mikrotik_Vlan_Id_Number,
			int Mikrotik_Vlan_Id_Type,
			string Password,
			Object Route,
			int Sessionlimit_Max_Session_Limit,
			ushort Simuse,
			string Subnet,
			string Username,
			ushort Vlan,
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
			logintime = Logintime;
			mikrotik_vlan_id_number = Mikrotik_Vlan_Id_Number;
			mikrotik_vlan_id_type = Mikrotik_Vlan_Id_Type;
			password = Password;
			route = Route;
			sessionlimit_max_session_limit = Sessionlimit_Max_Session_Limit;
			simuse = Simuse;
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
namespace OPNsense.freeradius {
	public class General {
		#region Parameters
		public bool chillispot { get; set; }
		public bool enabled { get; set; }
		public bool ldap_enabled { get; set; }
		public bool log_authbadpass { get; set; }
		public bool log_authentication_request { get; set; }
		public bool log_authgoodpass { get; set; }
		public PSObject log_destination { get; set; }
		public bool mikrotik { get; set; }
		public bool sessionlimit { get; set; }
		public bool sqlite { get; set; }
		public bool vlanassign { get; set; }
		public bool wispr { get; set; }
		#endregion Parameters

		public General () {
			chillispot = true;
			enabled = true;
			ldap_enabled = true;
			log_authbadpass = true;
			log_authentication_request = true;
			log_authgoodpass = true;
			log_destination = null;
			mikrotik = true;
			sessionlimit = true;
			sqlite = true;
			vlanassign = true;
			wispr = true;
		}

		public General (
			byte Chillispot,
			byte Enabled,
			byte Ldap_Enabled,
			byte Log_Authbadpass,
			byte Log_Authentication_Request,
			byte Log_Authgoodpass,
			PSObject Log_Destination,
			byte Mikrotik,
			byte Sessionlimit,
			byte Sqlite,
			byte Vlanassign,
			byte Wispr
		) {
			chillispot = (Chillispot == 0) ? false : true;
			enabled = (Enabled == 0) ? false : true;
			ldap_enabled = (Ldap_Enabled == 0) ? false : true;
			log_authbadpass = (Log_Authbadpass == 0) ? false : true;
			log_authentication_request = (Log_Authentication_Request == 0) ? false : true;
			log_authgoodpass = (Log_Authgoodpass == 0) ? false : true;
			log_destination = Log_Destination;
			mikrotik = (Mikrotik == 0) ? false : true;
			sessionlimit = (Sessionlimit == 0) ? false : true;
			sqlite = (Sqlite == 0) ? false : true;
			vlanassign = (Vlanassign == 0) ? false : true;
			wispr = (Wispr == 0) ? false : true;
		}
	}
}
namespace OPNsense.freeradius {
	public class Eap {
		#region Parameters
		public PSObject ca { get; set; }
		public PSObject certificate { get; set; }
		public PSObject crl { get; set; }
		public PSObject default_eap_type { get; set; }
		public bool enable_client_cert { get; set; }
		#endregion Parameters

		public Eap () {
			ca = null;
			certificate = null;
			crl = null;
			default_eap_type = null;
			enable_client_cert = true;
		}

		public Eap (
			PSObject Ca,
			PSObject Certificate,
			PSObject Crl,
			PSObject Default_Eap_Type,
			byte Enable_Client_Cert
		) {
			ca = Ca;
			certificate = Certificate;
			crl = Crl;
			default_eap_type = Default_Eap_Type;
			enable_client_cert = (Enable_Client_Cert == 0) ? false : true;
		}
	}
}
namespace OPNsense.freeradius {
	public class Ldap {
		#region Parameters
		public string base_dn { get; set; }
		public string group_filter { get; set; }
		public string identity { get; set; }
		public string password { get; set; }
		public PSObject protocol { get; set; }
		public string server { get; set; }
		public string user_filter { get; set; }
		#endregion Parameters

		public Ldap () {
			base_dn = "dc=example,dc=domain,dc=com";
			group_filter = "(objectClass=posixGroup)";
			identity = null;
			password = null;
			protocol = null;
			server = null;
			user_filter = "(uid=%{%{Stripped-User-Name}:-%{User-Name}})";
		}

		public Ldap (
			string Base_Dn,
			string Group_Filter,
			string Identity,
			string Password,
			PSObject Protocol,
			string Server,
			string User_Filter
		) {
			base_dn = Base_Dn;
			group_filter = Group_Filter;
			identity = Identity;
			password = Password;
			protocol = Protocol;
			server = Server;
			user_filter = User_Filter;
		}
	}
}
