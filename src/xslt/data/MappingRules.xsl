<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml"/> 
    <xsl:variable name="ModelTable">
        <xsl:for-each select="//*[name()='Model'][@Model.Type='MT_EEPC']">
            <xsl:value-of select="@Model.ID"/>
            <xsl:value-of select="concat(' ',position(),' ')"/>
        </xsl:for-each>
    </xsl:variable>
    <xsl:variable name="ObjDefTable">
        <xsl:for-each select="//*[name()='ObjDef']">
            <xsl:value-of select="@ObjDef.ID"/>
            <xsl:value-of select="concat(' ',position(),' ')"/>
        </xsl:for-each>
    </xsl:variable>
    <xsl:variable name="ObjOccTable">
        <xsl:for-each select="//*[name()='ObjOcc']">
            <xsl:value-of select="@ObjOcc.ID"/>
            <xsl:value-of select="concat(' ',position(),' ')"/>
        </xsl:for-each>
    </xsl:variable>
    <xsl:variable name="CxnOccFirst">
        <xsl:value-of select="count(//*[name()='ObjOcc'])+1"/>
    </xsl:variable>
    <xsl:variable name="CxnOccTable">
        <xsl:for-each select="//*[name()='CxnOcc']">
            <xsl:value-of select="@CxnOcc.ID"/>
            <xsl:value-of select="concat(' ',position(),' ')"/>
        </xsl:for-each>
    </xsl:variable>

    <xsl:template match="/">
        <bpmn2:definitions 
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
            xmlns:bpmn2="http://www.omg.org/spec/BPMN/20100524/MODEL" 
            xmlns:bpmndi="http://www.omg.org/spec/BPMN/20100524/DI" 
            xmlns:dc="http://www.omg.org/spec/DD/20100524/DC" 
            xmlns:di="http://www.omg.org/spec/DD/20100524/DI" 
            xmlns:mm="http://org.eclipse.bpmn2.modeler.examples.customtask" 
            xmlns:tl="http://www.w3.org/2001/XMLSchema" 
            id="Definitions_1" 
            exporter="org.eclipse.bpmn2.modeler.core" 
            exporterVersion="1.3.0.Final-v20160602-2145-B47" 
            targetNamespace="http://org.eclipse.bpmn2.modeler.examples.customtask">
            <bpmn2:process id="Order_process" name="Default Process" isExecutable="false">
                <definitions>
                    <xsl:for-each select="//*[name()='ObjDef']">
                        <xsl:element name="definition">
                            <xsl:attribute name="defId">
                                <xsl:value-of select="position()"/>
                            </xsl:attribute>
                        </xsl:element>
                    </xsl:for-each>
                </definitions>
            <!--
                <xsl:for-each select="AML/Group/ObjDef">
                    <xsl:variable name="ID_EVENT" select="@ObjDef.ID">
                        <xsl:if test="(@TypeNum='OT_FUNC') and (@SymbolNum='ST_FUNC')">
                            <xsl:for-each select="CxnDef"> 
                                <bpmn2:startEvent id="$ID_EVENT" name="Start">
                                    <bpmn2:outgoing>
                                        <xsl:value-of select="@ToObjDef.IdRef"/>
                                    </bpmn2:outgoing>
                                </bpmn2:startEvent>
                            </xsl:for-each> 
                        </xsl:if>
                    </xsl:variable>
                </xsl:for-each>
               
                
                <bpmn2:endEvent id="EndEvent_1" name="End">
                    <bpmn2:incoming>SequenceFlow_10</bpmn2:incoming>
                </bpmn2:endEvent>
                 -->
                <xsl:value-of select="AML/Group/ObjDef/AttrDef/AttrValue/StyledElement/StyledElement/PlainText/@TextValue"/>
                <xsl:apply-templates/>
            </bpmn2:process>
            
            <bpmndi:BPMNDiagram id="BPMNDiagram_1" name="Default Process Diagram">
                <bpmndi:BPMNPlane id="BPMNPlane_1" bpmnElement="Order_process">
                    
                </bpmndi:BPMNPlane>
            </bpmndi:BPMNDiagram>
        </bpmn2:definitions>

  
  
      
    </xsl:template>
       
</xsl:stylesheet>


