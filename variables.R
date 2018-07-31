# initiate global variable
appsTitle <- 'One Map - Compilation Tool'
appsMenu <- data.frame(
  menuItem = c('Metadata', 'Contact', 'Spatial Representation Info', 'Reference System Info', 'Identification Info',
               'Distribution Info', 'Transfer Options', 'Metadata Maintenace', 'Metadata Constrains'),
  tabName = c('metadata', 'contact', 'spatialRepresentationInfo', 'referenceSystemInfo', 'identificationInfo',
              'distributionInfo', 'transferOptions', 'metadataMaintenance', 'metadataConstraint')
)
# 1. metadata
mdEntity <- data.frame(
  vars = c('fileIdentifier', 'lang', 'charSet', 'hieLvl', 'mdStdName', 'mdStdVer', 'dateStamp', 'dataSetURI'),
  name = c('File Identifier', 'Language', 'Character Set', 'Hierarchy Level', 'Metadata Standard Name', 'Metadata Standard Version', 'Date Stamp', 'Data Set URI'),
  desc = c('', '', '', '', '', '', '', '')
)
# 2. contact
ctEntity <- data.frame(
  vars = c('indName', 'orgName', 'posName', 'phone', 'fax', 'delivPoint', 'city', 'postCode', 'country', 'emailAdd', 'linkage', 'protocol', 'function', 'hOfService', 'contIntructions', 'role'),
  name = c('Individual Name', 'Organisation Name', 'Position Name', 'Phone', 'Faximile', 'Delivery Point', 'City', 'Postal Code', 'Country', 'Email Address', 'Linkage', 'Protocol', 'Function', 'Hours Of Service', 'Contact Intructions', 'Role'),
  desc = c('', '', '', '', '', '', '', '')
)
# 3. spatial representation info
sriEntity <- data.frame(
  vars = c('topoLvl', 'geomObj', 'nOfDim', 'cornerPoints', 'pointInPxl', 'axixDimProp', 'dimName', 'dimSize', 'cellGeom', 'checkPointAvail', 'controlPointAvail', 'geoParam', 'objType'),
  name = c('Topology Level', 'Geometry Objects', 'Number Of Dimension', 'Corner Points', 'Point in Pixel', 'Axis Dimension Property', 'Dimension Name', 'Dimension Size', 'Cell Geometry', 'Check Point Availability', 'Control Point Availability', 'Georeference Parameters', 'Object Type'),
  desc = c('', '', '', '', '', '', '', '', '', '', '', '', '')
)
# 4. reference system info
refSysEntity <- data.frame(
  vars = c('title', 'date', 'dateType', 'orgName', 'linkage', 'role', 'code', 'version', 'Name', 'crs', 'semiMajorAxis', 'axisUnit'),
  name = c('Title', 'Date', 'Date Type', 'Organisation Name', 'Linkage', 'Role', 'Code', 'Version', 'Name', 'Coordinate Reference System', 'Semi Major Axis', 'Axis Unit'),
  desc = c('', '', '', '', '', '', '', '', '', '', '', '')
)
# 5. identification info
idInfoEntity <- data.frame(
  vars = c('citation', 'title', 'date', 'dateType', 'abstract', 'resMaintenance', 'descKey', 'spatRes', 'resCons', 'spatRepType', 'langIdent', 'charSetCode', 'topicCat', 'westBoundLong', 'eastBoundLong', 'southBoundLat', 'northBoundLat'),
  name = c('Citation', 'Title', 'Date', 'Date Type', 'Abstract', 'Resource Maintenance', 'Descriptive Keywords', 'Spatial Resolution', 'Resource Constraints', 'Spatial Representation Type', 'Language Identification', 'Character Set Code', 'Topic Category', 'West Bound Longitude', 'East Bound Longitude', 'South Bound Latitude', 'North Bound Latitude'),
  desc = c('', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '')
)
# 6. distribution info
disInfoEntity <- ctEntity
# 7. transfer options (4): WFS, WMS, ZIP Shapefile, ImageWMS
trfOptEntity <- data.frame(
  vars = c('linkage', 'protocol', 'name', 'description', 'func'),
  name = c('Linkage', 'Protocol', 'Name', 'Description', 'Function'),
  desc = c('', '', '', '', '')
)
# 8. metadata maintenance
mdMtncEntity <- data.frame(
  vars = c('updFreq', 'note'),
  name = c('Maintenance and Update Frequency', 'Maintenance Note'),
  desc = c('', '')
)
# 9. metadata constraints
mdConstEntity <- data.frame(
  vars = c('class', 'userNote', 'userLimit'),
  name = c('Classification', 'User Note', 'User Limitation'),
  desc = c('', '', '')
)