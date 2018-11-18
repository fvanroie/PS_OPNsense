using System;
using System.Management.Automation;

namespace OPNsense.postfix.domain.domains {
	public class Domain {
		#region Parameters
		public string destination { get; set; }
		public string domainname { get; set; }
		public bool enabled { get; set; }
		#endregion Parameters

		public Domain () {
			destination = null;
			domainname = null;
			enabled = true;
		}

		public Domain (
			string Destination,
			string Domainname,
			byte Enabled
		) {
			destination = Destination;
			domainname = Domainname;
			enabled = (Enabled == 0) ? false : true;
		}
	}
}
namespace OPNsense.postfix.recipient.recipients {
	public class Recipient {
		#region Parameters
		public PSObject action { get; set; }
		public string address { get; set; }
		public bool enabled { get; set; }
		#endregion Parameters

		public Recipient () {
			action = null;
			address = null;
			enabled = true;
		}

		public Recipient (
			PSObject Action,
			string Address,
			byte Enabled
		) {
			action = Action;
			address = Address;
			enabled = (Enabled == 0) ? false : true;
		}
	}
}
namespace OPNsense.postfix.sender.senders {
	public class Sender {
		#region Parameters
		public PSObject action { get; set; }
		public string address { get; set; }
		public bool enabled { get; set; }
		#endregion Parameters

		public Sender () {
			action = null;
			address = null;
			enabled = true;
		}

		public Sender (
			PSObject Action,
			string Address,
			byte Enabled
		) {
			action = Action;
			address = Address;
			enabled = (Enabled == 0) ? false : true;
		}
	}
}
namespace OPNsense.postfix {
	public class Antispam {
		#region Parameters
		public bool enable_rspamd { get; set; }
		#endregion Parameters

		public Antispam () {
			enable_rspamd = true;
		}

		public Antispam (
			byte Enable_Rspamd
		) {
			enable_rspamd = (Enable_Rspamd == 0) ? false : true;
		}
	}
}
namespace OPNsense.postfix {
	public class General {
		#region Parameters
		public string banner { get; set; }
		public PSObject bind_address { get; set; }
		public PSObject bind_address6 { get; set; }
		public PSObject ca { get; set; }
		public PSObject certificate { get; set; }
		public bool disable_ssl { get; set; }
		public bool disable_weak_ciphers { get; set; }
		public bool enabled { get; set; }
		public bool enforce_recipient_check { get; set; }
		public string inet_interfaces { get; set; }
		public PSObject inet_port { get; set; }
		public int message_size_limit { get; set; }
		public string mydomain { get; set; }
		public string myhostname { get; set; }
		public Object mynetworks { get; set; }
		public string myorigin { get; set; }
		public bool permit_mynetworks { get; set; }
		public bool permit_sasl_authenticated { get; set; }
		public bool permit_tls_clientcerts { get; set; }
		public bool reject_non_fqdn_recipient { get; set; }
		public bool reject_non_fqdn_sender { get; set; }
		public bool reject_unauth_destination { get; set; }
		public bool reject_unauth_pipelining { get; set; }
		public bool reject_unknown_recipient_domain { get; set; }
		public bool reject_unknown_sender_domain { get; set; }
		public string relayhost { get; set; }
		public bool smtpauth_enabled { get; set; }
		public string smtpauth_password { get; set; }
		public string smtpauth_user { get; set; }
		public PSObject smtpclient_security { get; set; }
		#endregion Parameters

		public General () {
			banner = null;
			bind_address = null;
			bind_address6 = null;
			ca = null;
			certificate = null;
			disable_ssl = true;
			disable_weak_ciphers = true;
			enabled = true;
			enforce_recipient_check = true;
			inet_interfaces = "all";
			inet_port = null;
			message_size_limit = 51200000;
			mydomain = null;
			myhostname = null;
			mynetworks = null;
			myorigin = null;
			permit_mynetworks = true;
			permit_sasl_authenticated = true;
			permit_tls_clientcerts = true;
			reject_non_fqdn_recipient = true;
			reject_non_fqdn_sender = true;
			reject_unauth_destination = true;
			reject_unauth_pipelining = true;
			reject_unknown_recipient_domain = true;
			reject_unknown_sender_domain = true;
			relayhost = null;
			smtpauth_enabled = true;
			smtpauth_password = null;
			smtpauth_user = null;
			smtpclient_security = null;
		}

		public General (
			string Banner,
			PSObject Bind_Address,
			PSObject Bind_Address6,
			PSObject Ca,
			PSObject Certificate,
			byte Disable_Ssl,
			byte Disable_Weak_Ciphers,
			byte Enabled,
			byte Enforce_Recipient_Check,
			string Inet_Interfaces,
			PSObject Inet_Port,
			int Message_Size_Limit,
			string Mydomain,
			string Myhostname,
			Object Mynetworks,
			string Myorigin,
			byte Permit_Mynetworks,
			byte Permit_Sasl_Authenticated,
			byte Permit_Tls_Clientcerts,
			byte Reject_Non_Fqdn_Recipient,
			byte Reject_Non_Fqdn_Sender,
			byte Reject_Unauth_Destination,
			byte Reject_Unauth_Pipelining,
			byte Reject_Unknown_Recipient_Domain,
			byte Reject_Unknown_Sender_Domain,
			string Relayhost,
			byte Smtpauth_Enabled,
			string Smtpauth_Password,
			string Smtpauth_User,
			PSObject Smtpclient_Security
		) {
			banner = Banner;
			bind_address = Bind_Address;
			bind_address6 = Bind_Address6;
			ca = Ca;
			certificate = Certificate;
			disable_ssl = (Disable_Ssl == 0) ? false : true;
			disable_weak_ciphers = (Disable_Weak_Ciphers == 0) ? false : true;
			enabled = (Enabled == 0) ? false : true;
			enforce_recipient_check = (Enforce_Recipient_Check == 0) ? false : true;
			inet_interfaces = Inet_Interfaces;
			inet_port = Inet_Port;
			message_size_limit = Message_Size_Limit;
			mydomain = Mydomain;
			myhostname = Myhostname;
			mynetworks = Mynetworks;
			myorigin = Myorigin;
			permit_mynetworks = (Permit_Mynetworks == 0) ? false : true;
			permit_sasl_authenticated = (Permit_Sasl_Authenticated == 0) ? false : true;
			permit_tls_clientcerts = (Permit_Tls_Clientcerts == 0) ? false : true;
			reject_non_fqdn_recipient = (Reject_Non_Fqdn_Recipient == 0) ? false : true;
			reject_non_fqdn_sender = (Reject_Non_Fqdn_Sender == 0) ? false : true;
			reject_unauth_destination = (Reject_Unauth_Destination == 0) ? false : true;
			reject_unauth_pipelining = (Reject_Unauth_Pipelining == 0) ? false : true;
			reject_unknown_recipient_domain = (Reject_Unknown_Recipient_Domain == 0) ? false : true;
			reject_unknown_sender_domain = (Reject_Unknown_Sender_Domain == 0) ? false : true;
			relayhost = Relayhost;
			smtpauth_enabled = (Smtpauth_Enabled == 0) ? false : true;
			smtpauth_password = Smtpauth_Password;
			smtpauth_user = Smtpauth_User;
			smtpclient_security = Smtpclient_Security;
		}
	}
}
