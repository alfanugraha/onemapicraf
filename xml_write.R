# set csw node
csw <- newXMLNode("GetRecordByIdResponse",
  namespace="csw",
  attrs=c("xsi:schemaLocation"="http://www.opengis.net/cat/csw/2.0.2 http://schemas.opengis.net/csw/2.0.2/CSW-discovery.xsd"),
  namespaceDefinitions=c("csw"="http://www.opengis.net/cat/csw/2.0.2",
                          "dc"="http://purl.org/dc/elements/1.1/",
                          "dct"="http://purl.org/dc/terms/",
                          "gco"="http://www.isotc211.org/2005/gco",
                          "gmd"="http://www.isotc211.org/2005/gmd",
                          "gml"="http://www.opengis.net/gml",
                          "ows"="http://www.opengis.net/ows",
                          "xs"="http://www.w3.org/2001/XMLSchema",
                          "xsi"="http://www.w3.org/2001/XMLSchema-instance"
                          )
  )

# set metadata node
MD_Metadata <- newXMLNode("MD_Metadata",
  namespace="gmd",
  attrs=c("xsi:schemaLocation"="http://www.isotc211.org/2005/gmd http://www.isotc211.org/2005/gmd/gmd.xsd http://www.isotc211.org/2005/gmx http://www.isotc211.org/2005/gmx/gmx.xsd"),
  parent=csw)
  fileIdentifier <- newXMLNode("fileIdentifier", namespace="gmd", parent=MD_Metadata)
    CharacterString <- newXMLNode(name="CharacterString", namespace="gco", parent=fileIdentifier)
      addChildren(CharacterString, "ini harus diisi")
  language <- newXMLNode("language", namespace="gmd", parent=MD_Metadata)
    languageCode <- newXMLNode(name="LanguageCode", namespace="gmd", attrs=c("codeList"="http://www.loc.gov/standards/iso639-2/", "codeListValue"="http://schemas.opengis.net/csw/2.0.2/CSW-discovery.xsd", "codeSpace"="ISO 639-2"), parent=language)
      addChildren(languageCode, "ini harus diisi")
  characterSet <- newXMLNode("characterSet", namespace="gmd", parent=MD_Metadata)
    MD_CharacterSetCode <- newXMLNode(name="MD_CharacterSetCode", namespace="gmd", attrs=c("codeList"="http://www.loc.gov/standards/iso639-2/", "codeListValue"="http://schemas.opengis.net/csw/2.0.2/CSW-discovery.xsd", "codeSpace"="ISO 639-2"), parent=characterSet)
      addChildren(MD_CharacterSetCode, "ini harus diisi")

