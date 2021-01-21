// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------

/// <summary>
/// Provides functions for signing
/// </summary>
codeunit 1570 "Certificate Signing"
{
    Access = Public;
    /// <summary>
    /// Initializes SignedXML
    /// </summary>
    /// <param name="Xml">XML that needs to be signed.</param>
    procedure SetSignedXML(Xml: Text)
    begin
        CertificateSigning.SetSignedXML(Xml);
    end;

    /// <summary>
    /// Initializes DotNetX509Certificate2 and imports certifiacte.
    /// </summary>
    /// <param name="Base64Cert">Certificate in Base64 format.</param>
    /// <param name="Password">Password for certificate.</param>
    /// <returns>Return variable IsSuccess of type Boolean. If certificate is succesfuly read</returns>
    [NonDebuggable]
    procedure ReadCertificate(Base64Cert: Text; Password: Text) IsSuccess: Boolean
    begin
        exit(CertificateSigning.ReadCertificate(Base64Cert, Password));
    end;

    #region Set Csp Parameters
    /// <summary>
    /// Initializes a new instance of the CspParameters class.
    /// </summary>
    /// <see cref="https://docs.microsoft.com/en-us/dotnet/api/system.security.cryptography.cspparameters.-ctor?view=net-5.0#System_Security_Cryptography_CspParameters__ctor"/>
    procedure SetCspParameters()
    begin
        CertificateSigning.SetCspParameters();
    end;

    /// <summary>
    /// Initializes a new instance of the CspParameters class with the specified provider type code.
    /// </summary>
    /// <param name="dwTypeIn">IA provider type code that specifies the kind of provider to create.</param>
    /// <see cref="https://docs.microsoft.com/en-us/dotnet/api/system.security.cryptography.cspparameters.-ctor?view=net-5.0#System_Security_Cryptography_CspParameters__ctor_System_Int32_"/>
    procedure SetCspParameters(dwTypeIn: Integer)
    begin
        CertificateSigning.SetCspParameters(dwTypeIn);
    end;

    /// <summary>
    /// Initializes a new instance of the CspParameters class with the specified provider type code and name.
    /// </summary>
    /// <param name="dwTypeIn">A provider type code that specifies the kind of provider to create.</param>
    /// <param name="strProviderNameIn">A provider name.</param>
    /// <see cref="https://docs.microsoft.com/en-us/dotnet/api/system.security.cryptography.cspparameters.-ctor?view=net-5.0#System_Security_Cryptography_CspParameters__ctor_System_Int32_System_String_"/>
    procedure SetCspParameters(dwTypeIn: Integer; strProviderNameIn: Text)
    begin
        CertificateSigning.SetCspParameters(dwTypeIn, strProviderNameIn);
    end;

    /// <summary>
    /// Initializes a new instance of the CspParameters class with the specified provider type code and name, and the specified container name.
    /// </summary>
    /// <param name="dwTypeIn">A provider type code that specifies the kind of provider to create.</param>
    /// <param name="strProviderNameIn">A provider name.</param>
    /// <param name="strContainerNameIn">A container name.</param>
    /// <see cref="https://docs.microsoft.com/en-us/dotnet/api/system.security.cryptography.cspparameters.-ctor?view=net-5.0#System_Security_Cryptography_CspParameters__ctor_System_Int32_System_String_System_String_"/>
    procedure SetCspParameters(dwTypeIn: Integer; strProviderNameIn: Text; strContainerNameIn: Text)
    begin
        CertificateSigning.SetCspParameters(dwTypeIn, strProviderNameIn, strContainerNameIn);
    end;
    #endregion
    /// <summary>
    /// Gets or sets a value indicating whether the key should be persisted in the cryptographic service provider (CSP).
    /// </summary>
    /// <param name="SetKey">Set presist key</param>
    /// <see cref="https://docs.microsoft.com/en-us/dotnet/api/system.security.cryptography.rsacryptoserviceprovider.persistkeyincsp?view=net-5.0"/>
    procedure SetRSAPresistKeyInCps(SetKey: Boolean)
    begin
        CertificateSigning.SetRSAPresistKeyInCps(SetKey);
    end;

    /// <summary>
    /// Set include private parameters in X509Certificate2.PrivateKey
    /// </summary>
    /// <param name="SetInclude">Boolean.</param>
    procedure SetIncludePrivParams(SetInclude: Boolean)
    begin
        CertificateSigning.SetIncludePrivParams(SetInclude);
    end;

    /// <summary>
    /// Initializes a new instance of the Reference class with the specified Uri.
    /// </summary>
    /// <param name="uri">The Uri with which to initialize the new instance of Reference.</param>
    /// <see cref="https://docs.microsoft.com/en-us/dotnet/api/system.security.cryptography.xml.reference.-ctor?view=dotnet-plat-ext-5.0#System_Security_Cryptography_Xml_Reference__ctor_System_String_"/>
    procedure InitXMLReference(uri: Text)
    begin
        CertificateSigning.InitXMLReference(uri)
    end;

    /// <summary>
    /// Adds a Transform object to the list of transforms to be performed on the data before passing it to the digest algorithm.
    /// </summary>
    /// <param name="CryptographyTransform">The transform to be added to the list of transforms. Enum "CryptographyTransform".</param>
    /// <see cref="https://docs.microsoft.com/en-us/dotnet/api/system.security.cryptography.xml.reference.addtransform?view=dotnet-plat-ext-5.0#System_Security_Cryptography_Xml_Reference_AddTransform_System_Security_Cryptography_Xml_Transform_"/>
    procedure AddTransform(XMLCryptographyTransform: Enum "XMLCryptographyTransform")
    begin
        CertificateSigning.AddTransform(XMLCryptographyTransform);
    end;

    /// <summary>
    /// Gets or sets the digest method Uniform Resource Identifier (URI) of the current Reference.
    /// </summary>
    /// <param name="DigestMethod">The digest method URI of the current Reference. The default value is http://www.w3.org/2001/04/xmlenc#sha256.</param>
    /// <see cref="https://docs.microsoft.com/en-us/dotnet/api/system.security.cryptography.xml.reference.digestmethod?view=dotnet-plat-ext-5.0#System_Security_Cryptography_Xml_Reference_DigestMethod"/>
    procedure AddDigestMethod(DigestMethod: Text)
    begin
        CertificateSigning.AddDigestMethod(DigestMethod);
    end;

    /// <summary>
    /// Sets the signature method of the current SignedXml object.
    /// </summary>
    /// <param name="SignatureMethod">The name of the algorithm used for signature generation and validation for the current SignedInfo object.</param>
    /// <see cref="https://docs.microsoft.com/en-us/dotnet/api/system.security.cryptography.xml.signedinfo.signaturemethod?view=dotnet-plat-ext-5.0#System_Security_Cryptography_Xml_SignedInfo_SignatureMethod"/>
    procedure AddSignatureMethod(SignatureMethod: Text)
    begin
        CertificateSigning.AddSignatureMethod(SignatureMethod);
    end;

    /// <summary>
    /// Gets or sets the canonicalization algorithm that is used before signing for the current SignedInfo object.
    /// </summary>
    /// <param name="CanonicalizationMethod">The canonicalization algorithm used before signing for the current SignedInfo object.</param>
    /// <see cref="https://docs.microsoft.com/en-us/dotnet/api/system.security.cryptography.xml.signedinfo.canonicalizationmethod?view=dotnet-plat-ext-5.0#System_Security_Cryptography_Xml_SignedInfo_CanonicalizationMethod"/>
    procedure AddCanonicalizationMethod(CanonicalizationMethod: Text)
    begin
        CertificateSigning.AddCanonicalizationMethod(CanonicalizationMethod);
    end;

    /// <summary>
    /// Returns the XML representation of a SignedXml object.
    /// </summary>
    /// <returns>Returns Tex the XML representation of the Signature object.</returns>
    /// <see cref="https://docs.microsoft.com/en-us/dotnet/api/system.security.cryptography.xml.signedxml.getxml?view=dotnet-plat-ext-5.0#System_Security_Cryptography_Xml_SignedXml_GetXml"/>
    procedure GetSignedXML(): Text
    begin
        exit(CertificateSigning.GetSignedXML());
    end;
    /// <summary>
    /// Computes the signature for the specified hash value.
    /// </summary>
    /// <param name="DataBase64">The hash value of the data to be signed.</param>
    /// <param name="name">The hash algorithm identifier (OID) used to create the hash value of the data.</param>
    /// <returns>Return value of type Text Base64 format. The RSA signature for the specified hash value.</returns>
    /// <see cref="https://docs.microsoft.com/en-us/dotnet/api/system.security.cryptography.rsacryptoserviceprovider.signhash?view=net-5.0#System_Security_Cryptography_RSACryptoServiceProvider_SignHash_System_Byte___System_String_"/>
    procedure GetSignedHashToBase64(DataBase64: Text; name: Text): Text
    begin
        exit(CertificateSigning.GetSignedHashToBase64(DataBase64, name));
    end;

    var
        CertificateSigning: Codeunit "Certificate Signing Impl";
}
