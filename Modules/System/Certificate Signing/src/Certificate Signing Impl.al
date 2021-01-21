codeunit 1571 "Certificate Signing Impl"
{
    Access = Internal;
    procedure SetSignedXML(Xml: Text)
    var
        XMLDocument: DotNet XmlDocument;
    begin
        XMLDocument := XMLDocument.XmlDocument();
        XMLDocument.LoadXml(Xml);
        SignedXml := SignedXml.SignedXml(XMLDocument);
    end;

    [NonDebuggable]
    [TryFunction]
    procedure ReadCertificate(Base64Cert: Text; Password: Text)
    var
        DotNetArray: DotNet Array;
        Convert: DotNet Convert;
        DotNetX509KeyStorageFlags: DotNet X509KeyStorageFlags;

    begin
        DotNetArray := Convert.FromBase64String(Base64Cert);
        DotNetX509KeyStorageFlags := DotNetX509KeyStorageFlags.Exportable;
        X509Certificate2 := X509Certificate2.X509Certificate2(DotNetArray, Password, DotNetX509KeyStorageFlags);
    end;
    #region Set Csp Parameters
    procedure SetCspParameters()
    begin
        CspParameters := CspParameters.CspParameters();
    end;

    procedure SetCspParameters(dwTypeIn: Integer)
    begin
        CspParameters := CspParameters.CspParameters(dwTypeIn);
    end;

    procedure SetCspParameters(dwTypeIn: Integer; strProviderNameIn: Text)
    begin
        CspParameters := CspParameters.CspParameters(dwTypeIn, strProviderNameIn);
    end;

    procedure SetCspParameters(dwTypeIn: Integer; strProviderNameIn: Text; strContainerNameIn: Text)
    begin
        CspParameters := CspParameters.CspParameters(dwTypeIn, strProviderNameIn, strContainerNameIn);
    end;
    #endregion

    procedure SetRSAPresistKeyInCps(SetKey: Boolean)
    begin
        PersistKeyInCsp := SetKey
    end;

    procedure SetIncludePrivParams(SetInclude: Boolean)
    begin
        includePrivateParameters := SetInclude;
    end;

    procedure InitXMLReference(uri: Text)
    begin
        XMLReference := XMLReference.Reference(uri);
    end;

    procedure AddTransform(XMLCryptographyTransform: Enum "XMLCryptographyTransform")
    var
        XMLDecryptionTransform: DotNet XmlDecryptionTransform;
        XmlDsigBase64Transform: DotNet XmlDsigBase64Transform;
        XmlDsigC14NTransform: DotNet XmlDsigC14NTransform;
        XmlDsigEnvelopedTransform: DotNet XmlDsigEnvelopedSignatureTransform;
        XmlDsigExcC14NTransform: DotNet XmlDsigExcC14NTransform;
        XmlDsigXPathTransform: DotNet XmlDsigXPathTransform;
        XmlDsigXsltTransform: DotNet XmlDsigXsltTransform;
        XmlLicenseTransform: DotNet XmlLicenseTransform;
    begin
        case XMLCryptographyTransform of
            XMLCryptographyTransform::XmlDecryptionTransform:
                XMLReference.AddTransform(XMLDecryptionTransform.XmlDecryptionTransform());
            XMLCryptographyTransform::XmlDsigBase64Transform:
                XMLReference.AddTransform(XmlDsigBase64Transform.XmlDsigBase64Transform());
            XMLCryptographyTransform::XmlDsigC14NTransform:
                XMLReference.AddTransform(XmlDsigC14NTransform.XmlDsigC14NTransform());
            XMLCryptographyTransform::XmlDsigEnvelopedSignatureTransform:
                XMLReference.AddTransform(XmlDsigEnvelopedTransform.XmlDsigEnvelopedSignatureTransform());
            XMLCryptographyTransform::XmlDsigExcC14NTransform:
                XMLReference.AddTransform(XmlDsigExcC14NTransform.XmlDsigExcC14NTransform());
            XMLCryptographyTransform::XmlDsigXPathTransform:
                XMLReference.AddTransform(XmlDsigXPathTransform.XmlDsigXPathTransform());
            XMLCryptographyTransform::XmlDsigXsltTransform:
                XMLReference.AddTransform(XmlDsigXsltTransform.XmlDsigXsltTransform());
            XMLCryptographyTransform::XmlLicenseTransform:
                XMLReference.AddTransform(XmlLicenseTransform.XmlLicenseTransform());
        end;
    end;

    procedure AddDigestMethod(DigestMethod: Text)
    begin
        XMLReference.DigestMethod(DigestMethod);
    end;

    procedure AddSignatureMethod(SignatureMethod: Text)
    begin
        SignedXml.SignedInfo.SignatureMethod(SignatureMethod);
    end;

    procedure AddCanonicalizationMethod(CanonicalizationMethod: Text)
    begin
        SignedXml.SignedInfo.CanonicalizationMethod(CanonicalizationMethod);
    end;

    local procedure InitializeRSACryptoServiceProvider(var RSACryptoServiceProvider: DotNet RSACryptoServiceProvider)
    begin
        RSACryptoServiceProvider := RSACryptoServiceProvider.RSACryptoServiceProvider(CspParameters);
        RSACryptoServiceProvider.PersistKeyInCsp := PersistKeyInCsp;
        RSACryptoServiceProvider.FromXmlString(X509Certificate2.PrivateKey.ToXmlString(includePrivateParameters));
    end;

    procedure GetSignedXML(): Text
    var
        RSACryptoServiceProvider: DotNet RSACryptoServiceProvider;
    begin
        InitializeRSACryptoServiceProvider(RSACryptoServiceProvider);
        SignedXml.SigningKey := RSACryptoServiceProvider;
        SignedXml.AddReference(XMLReference);
        SignedXml.ComputeSignature;

        exit(SignedXml.GetXml.InnerXml);
    end;

    procedure GetSignedHashToBase64(DataBase64: Text; name: Text): Text
    var
        Convert: DotNet Convert;
        RSACryptoServiceProvider: DotNet RSACryptoServiceProvider;
        CryptoConfig: DotNet CryptoConfig;
    begin
        InitializeRSACryptoServiceProvider(RSACryptoServiceProvider);
        exit(Convert.ToBase64String(RSACryptoServiceProvider.SignHash(Convert.FromBase64String(DataBase64), CryptoConfig.MapNameToOID(name))));
    end;

    var
        includePrivateParameters: Boolean;
        PersistKeyInCsp: Boolean;
        CspParameters: DotNet CspParameters;
        XMLReference: DotNet Reference;
        SignedXml: DotNet SignedXml;
        X509Certificate2: DotNet X509Certificate2;
}
