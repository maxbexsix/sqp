SET FEEDBACK OFF
prompt Creating Public Synonyms...

BEGIN
  dbo.dbtools.GeneratePublicSynonyms('DBO');
  dbo.dbtools.GeneratePublicSynonyms('USAGE');
  dbo.dbtools.GeneratePublicSynonyms('UCS');
END;
/

prompt Done.
EXIT;
