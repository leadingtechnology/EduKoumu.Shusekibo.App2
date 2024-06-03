
import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xml/xml.dart' as xml;

final samlServiceProvider = Provider(SamlService.new);

class SamlService {
  SamlService(this._ref);

  final Ref _ref;

  String generateSamlRequest(
    String azureUrl,
    String callBackUrl,
    String frontendUrl,
  ) {
    final builder = xml.XmlBuilder();
    builder.element(
      'samlp:AuthnRequest',
      nest: () {
        builder
          ..attribute('xmlns:samlp', 'urn:oasis:names:tc:SAML:2.0:protocol')
          ..attribute(
            'ID',
            '_${DateTime.now().millisecondsSinceEpoch}',
          ) 
          ..attribute('Version', '2.0')
          ..attribute(
            'IssueInstant',
            DateTime.now().toUtc().toIso8601String(),
          ) 
          ..attribute(
            'Destination',
            azureUrl,
          )
          ..attribute(
            'AssertionConsumerServiceURL',
            callBackUrl,
          )
          ..attribute(
            'ProtocolBinding',
            'urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST',
          )
          ..element(
            'saml:Issuer',
            nest: () {
              builder
                ..attribute(
                  'xmlns:saml',
                  'urn:oasis:names:tc:SAML:2.0:assertion',
                )
                ..text(frontendUrl);
            },
          )
          ..element(
            'samlp:NameIDPolicy',
            nest: () {
              builder
                ..attribute('AllowCreate', 'true')
                ..attribute(
                  'Format',
                  'urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified',
                );
            },
          );
      },
    );

    final samlRequestXml = builder.buildDocument().toString();
    final bytes = utf8.encode(samlRequestXml);
    final base64SamlRequest = base64.encode(bytes);

    return base64SamlRequest;
  }

  Future<void> azureLogin() async {
    var tenantId = '';
    if (dotenv.env['TENANT_ID'] != null) {
      tenantId = dotenv.env['TENANT_ID']!;
    }

    var azureTenantID = '';
    if (dotenv.env['Saml_Tenant_ID'] != null) {
      azureTenantID = dotenv.env['Saml_Tenant_ID']!;
    }

    var callBackUrl = '';
    if (dotenv.env['Callback_URL'] != null) {
      callBackUrl = dotenv.env['Callback_URL']!;
    }

    var frontendUrl = '';
    if (dotenv.env['Frontend_URL'] != null) {
      frontendUrl = dotenv.env['Frontend_URL']!;
    }

    final url = 'https://login.microsoftonline.com/$azureTenantID/saml2';
    final samlRequest = generateSamlRequest(url, callBackUrl, frontendUrl);

    final form = html.FormElement()
      ..method = 'POST'
      ..action = url;

    final samlRequestField = html.HiddenInputElement()
      ..name = 'SAMLRequest'
      ..value = samlRequest;
    form.append(samlRequestField);

    final relayStateField = html.HiddenInputElement()
      ..name = 'RelayState'
      ..value = 'tenantId=$tenantId&frontendUrl=$frontendUrl';
    form.append(relayStateField);

    html.document.body!.append(form);
    form.submit();
  }

  Future<void> googleLogin() async {
    var tenantId = '';
    if (dotenv.env['TENANT_ID'] != null) {
      tenantId = dotenv.env['TENANT_ID']!;
    }

    var azureTenantID = '';
    if (dotenv.env['Saml_Tenant_ID'] != null) {
      azureTenantID = dotenv.env['Saml_Tenant_ID']!;
    }

    var callBackUrl = '';
    if (dotenv.env['Callback_URL'] != null) {
      callBackUrl = dotenv.env['Callback_URL']!;
    }

    var frontendUrl = '';
    if (dotenv.env['Frontend_URL'] != null) {
      frontendUrl = dotenv.env['Frontend_URL']!;
    }

    final url = 'https://login.microsoftonline.com/$azureTenantID/saml2';
    final samlRequest = generateSamlRequest(url, callBackUrl, frontendUrl);

    final form = html.FormElement()
      ..method = 'POST'
      ..action = url;

    final samlRequestField = html.HiddenInputElement()
      ..name = 'SAMLRequest'
      ..value = samlRequest;
    form.append(samlRequestField);

    final relayStateField = html.HiddenInputElement()
      ..name = 'RelayState'
      ..value = 'tenantId=$tenantId&frontendUrl=$frontendUrl';
    form.append(relayStateField);

    html.document.body!.append(form);
    form.submit();
  }
}
