<CreateClass>
    <ContentClass isContainer="false" identifier="video" objectNamePattern="&lt;name&gt;"
                  urlAliasPattern=""  classExistAction="">
        <Names always-available="fre-FR" fre-FR="Video"/>
        <Groups>
            <Group id="3" name="Media"/>
        </Groups>
        <Attributes>
            <Attribute datatype="ezstring" required="true" searchable="true" informationCollector="false" translatable="true"
                       identifier="name" placement="1">
                <Names always-available="fre-FR" fre-FR="Nom"/>
                <DatatypeParameters>
                    <attribute>
                        <datatype-parameters>
                            <max-length>150</max-length>
                            <default-string/>
                        </datatype-parameters>
                    </attribute>


                </DatatypeParameters>
            </Attribute>

            <Attribute datatype="ezbinaryfile" required="false" searchable="false" informationCollector="false" translatable="true"
                       identifier="file" placement="2">
                <Names fre-FR="Fichier" always-available="fre-FR"/>
                <DatatypeParameters>
                    <attribute>
                        <datatype-parameters>
                            <max-size unit-size="mega">64</max-size>
                        </datatype-parameters>
                    </attribute>
                </DatatypeParameters>
            </Attribute>
            <Attribute datatype="ezxmltext" required="false" searchable="true" informationCollector="false" translatable="true" identifier="caption"
                       placement="3">
                <Names eng-GB="Caption" always-available="eng-GB"/>
                <DatatypeParameters>
                    <attribute>
                        <datatype-parameters>
                            <text-column-count>10</text-column-count>
                        </datatype-parameters>
                    </attribute>


                </DatatypeParameters>
            </Attribute>
            <Attribute datatype="ezsrrating" required="false" searchable="true" informationCollector="false" translatable="true" identifier="star_rating"
                       placement="4">
                <Names eng-GB="Star+Rating" always-available="eng-GB"/>
                <DatatypeParameters>
                    <attribute>
                        <datatype-parameters/>
                    </attribute>

                </DatatypeParameters>
            </Attribute>
        </Attributes>
    </ContentClass>
</CreateClass>