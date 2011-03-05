<?xml version="1.0" encoding="UTF-8"?>
<rules>
    <rule>
        <whitelist>solitary:security\..*</whitelist>
        <securelist>\..*</securelist>
        <roles>admin,author</roles>
        <permissions></permissions>
        <redirect>security/login</redirect>
		<useSSL>false</useSSL>
    </rule>
</rules>