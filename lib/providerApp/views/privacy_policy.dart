import 'package:flutter/material.dart';
class PrivacyPolicy extends StatefulWidget {
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Text("Privacy Policy",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
            SizedBox(height: 20,),
            Text("Notice of Information Practices and Privacy Statement\r\nKARMA CONSULTING AND PR LTD (Company number 12854565) trading as Metis \r\nKemp House, 160 City Road, London, United Kingdom, EC1V 2NX\r\n \r\nHow We Collect Information About You\r\nKARMA CONSULTING AND PR LTD (Metis) and its employees and volunteers collect data through a variety of means including but not necessarily limited to letters, phone calls, emails, voicemails, and from the submission of applications that are either required by law or necessary to process applications or other requests for assistance through our organisation.\r\nWhat We Do Not Do With Your Information: \r\nInformation about your financial situation and medical conditions and care that you provide to us in writing, via email, on the phone (including information left on voicemails), contained in or attached to applications, or directly or indirectly given to us, is held in strictest confidence.\r\nWe do not give out, exchange, barter, rent, sell, lend, or disseminate any information about applicants or clients who apply for or actually receive our services that are considered patient confidential, restricted by law, or specifically restricted by a patient/client in a signed HIPAA consent form.\r\nHow We Do Use Your Information: \r\nInformation is only used as is reasonably necessary to process your application or to provide you with health or counselling services which may require communication between Metis and health care providers, medical product or service providers, pharmacies, insurance companies, and other providers necessary to verify your medical information is accurate and determine the type of medical supplies or health care services you need. This is including, but not limited to, or to obtain or purchase any type of medical supplies, devices, medications, or insurance.\r\nIf you apply or attempt to apply to receive assistance through us and provide information with the intent or purpose of fraud or that results in either an actual crime of fraud for any reason including willful or un-willful acts of negligence whether intended or not, or in any way demonstrates or indicates attempted fraud, your non-medical information can be given to legal authorities including police, investigators, courts, and/or attorneys or other legal professionals, as well as any other information as permitted by law.\r\nInformation We Do Not Collect: \r\nWe do not use cookies in our app to collect data from our visitors. We do not collect information about app visitors except for one hit counter on downloads that simply records the number of visitors and no other data. We do use some affiliate programs that may or may not capture traffic data through our site. \r\nLimited Right to Use Non-Identifying Personal Information From Biographies, Letters, Notes, and Other Sources: \r\nAny pictures, stories, letters, biographies, correspondence, or thank you notes sent to us become the exclusive property of Metis. We reserve the right to use non-identifying information about our clients (those who receive services or goods from or through us) for fundraising and promotional purposes that are directly related to our mission.\r\nClients will not be compensated for use of this information and no identifying information (photos, addresses, phone numbers, contact information, last names or uniquely identifiable names) will be used without the client’s express advance permission.\r\nYou may specifically request that NO information be used whatsoever for promotional purposes, but you must identify any requested restrictions in writing. We respect your right to privacy and assure you no identifying information or photos that you send to us will ever be publicly used without your direct or indirect consent."),
          ],
        ),
      ),
    );
  }
}
