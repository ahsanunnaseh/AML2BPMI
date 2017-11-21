<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xmlns:bpmn2="http://www.omg.org/spec/BPMN/20100524/MODEL" 
                xmlns:bpmndi="http://www.omg.org/spec/BPMN/20100524/DI" 
                xmlns:dc="http://www.omg.org/spec/DD/20100524/DC" 
                xmlns:di="http://www.omg.org/spec/DD/20100524/DI" 
                xmlns:mm="http://org.eclipse.bpmn2.modeler.examples.customtask" 
                xmlns:tl="http://www.w3.org/2001/XMLSchema"                version="1.0">
    <xsl:output method="xml" indent="yes"/>
    
    <!-- Untuk memastikan bahwa yang diinputkan adalah model EPC -->
    <xsl:variable name="ModelTable"> 
        <xsl:for-each select="//*[name()='Model'][@Model.Type='MT_EEPC']">
            <xsl:value-of select="@Model.ID"/>
            <xsl:value-of select="concat(' ',position(),' ')"/>
        </xsl:for-each>
    </xsl:variable>
    
    <!--  ObjDef (Object Definition) merepresentasikan logical event -->
    <xsl:variable name="ObjDefTable">
        <xsl:for-each select="//*[name()='ObjDef']">
            <xsl:value-of select="@ObjDef.ID"/>
            <xsl:value-of select="concat(' ',position(),' ')"/>
        </xsl:for-each>
    </xsl:variable>
    
    <!-- ObjOcc (Object Occurence) menampilkan logical event pada diagram grafis  -->
    <xsl:variable name="ObjOccTable">
        <xsl:for-each select="//*[name()='ObjOcc']">
            <xsl:value-of select="@ObjOcc.ID"/>
            <xsl:value-of select="concat(' ',position(),' ')"/>
        </xsl:for-each>
    </xsl:variable>
    
    <!-- menghitung jumlah ObjOcc  -->
    <xsl:variable name="CxnOccFirst">
        <xsl:value-of select="count(//*[name()='ObjOcc'])+1"/>
    </xsl:variable>
    
    <!-- CxnOcc membungkus CxnDef  -->
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
            <!-- Mendapatkan bpmn id dan name -->
            <bpmn2:process id="Order_process" name="Default Process" isExecutable="false">
             
                <!-- 1. Rule 1 Start Event ==> Event Without Incoming Control Flow 
               Kondisi start event, Jika:
                a. Pada attribut objDef, Tidak ada value ToCxnDefs.IdRefs
                b. TypeNum="OT_EVT"
                c. SymbolNum="ST_EV"
                d. Start Event bisa lebih dari satu-->
                <xsl:for-each select="AML/Group/ObjDef">
                    <!--
                    <xsl:if test="(@TypeNum='OT_EVT') and (@SymbolNum='ST_EV') and boolean(@ToCxnDefs.IdRefs)">
                        <xsl:for-each select="CxnDef"> 
                            <bpmn2:startEvent id="$ID_EVENT" name="Start">
                                <bpmn2:outgoing>
                                    <xsl:value-of select="@ToObjDef.IdRef"/>
                                </bpmn2:outgoing>
                            </bpmn2:startEvent>
                        </xsl:for-each> 
                    </xsl:if> -->
               <!--         
                    <xsl:choose>
                        <xsl:when test="(@TypeNum='OT_EVT') and (@SymbolNum='ST_EV') and boolean(@ToCxnDefs.IdRefs)">
                            <xsl:for-each select="CxnDef"> 
                                <bpmn2:startEvent id="$ID_EVENT" name="Start">
                                    <bpmn2:outgoing>
                                        <xsl:value-of select="@ToObjDef.IdRef"/>
                                    </bpmn2:outgoing>
                                </bpmn2:startEvent>
                            </xsl:for-each> 
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:for-each select="CxnDef"> 
                                <bpmn2:startEvent id="$ID_EVENT" name="End Event">
                                    <bpmn2:outgoing>
                                        <xsl:value-of select="@ToObjDef.IdRef"/>
                                    </bpmn2:outgoing>
                                </bpmn2:startEvent>
                            </xsl:for-each> 
                        </xsl:otherwise>
                    </xsl:choose>     -->
                </xsl:for-each>
     
               
                <!-- 2. Rule 2 End Event ==> Event Without Outgoing Control Flow-->
                <bpmn2:endEvent id="EndEvent_1" name="End">
                    <bpmn2:incoming>SequenceFlow_10</bpmn2:incoming>
                </bpmn2:endEvent>
                <!-- 3. Function ==> Activity -->
                <bpmn2:task id="Task_10" mm:type="MyTask" name="Receive Request">
                    <bpmn2:extensionElements>
                        <mm:taskConfig>
                            <mm:parameter xsi:type="mm:Parameter" name="txt_AnnotationEffect" value="exists(A,exists(B,exists(C,&amp;(object(D,A,request,countable,na,eq,1)-1/2,&amp;(object(D,B,operator,countable,na,eq,1)-1/7,predicate(D,C,accept,B,A)-1/4)))))&#xA;&#xA;"/>
                            <mm:parameter xsi:type="mm:Parameter" name="txt_ImmediateEffect" value="A request is accepted by an operator."/>
                        </mm:taskConfig>
                    </bpmn2:extensionElements>
                    <bpmn2:incoming>SequenceFlow_13</bpmn2:incoming>
                    <bpmn2:outgoing>SequenceFlow_17</bpmn2:outgoing>
                </bpmn2:task>
                <!-- 4. AND Connector ==>  -->
                <bpmn2:parallelGateway id="ParallelGateway_1" gatewayDirection="Diverging">
                    <bpmn2:incoming>SequenceFlow_21</bpmn2:incoming>
                    <bpmn2:outgoing>SequenceFlow_22</bpmn2:outgoing>
                    <bpmn2:outgoing>SequenceFlow_23</bpmn2:outgoing>
                </bpmn2:parallelGateway>
                <!-- 5. OR Connector ==> -->
                <!-- 6. XOR Connector ==> -->
                <bpmn2:exclusiveGateway id="ExclusiveGateway_1" gatewayDirection="Diverging">
                    <bpmn2:incoming>SequenceFlow_18</bpmn2:incoming>
                    <bpmn2:outgoing>SequenceFlow_19</bpmn2:outgoing>
                    <bpmn2:outgoing>SequenceFlow_20</bpmn2:outgoing>
                </bpmn2:exclusiveGateway> 
               
                <!-- 7. Organizational Unit ==> -->
                <!-- 8. Data ==>  ==> -->
                <!-- 9. System  ==> -->
                <!-- 10.Process Interface  ==> -->
                <!--Sequence Flow -->
                <bpmn2:sequenceFlow id="SequenceFlow_10" sourceRef="ExclusiveGateway_2" targetRef="EndEvent_1"/>
            </bpmn2:process>
        </bpmn2:definitions>
        
        <!-- Mengatur Layout Notasi -->
        <bpmndi:BPMNDiagram id="BPMNDiagram_1" name="Default Process Diagram">
            <bpmndi:BPMNPlane id="BPMNPlane_1" bpmnElement="Order_process">
                <!-- BPMN Shape -->
                <bpmndi:BPMNShape id="BPMNShape_Task_8" bpmnElement="Task_8" isExpanded="true">
                    <dc:Bounds height="50.0" width="110.0" x="260.0" y="287.0"/>
                    <bpmndi:BPMNLabel id="BPMNLabel_12">
                        <dc:Bounds height="15.0" width="86.0" x="272.0" y="304.0"/>
                    </bpmndi:BPMNLabel>
                </bpmndi:BPMNShape>
                
                <!-- BPMN Edge -->
                <bpmndi:BPMNEdge id="BPMNEdge_SequenceFlow_10" bpmnElement="SequenceFlow_10" sourceElement="BPMNShape_ExclusiveGateway_2" targetElement="BPMNShape_2">
                    <di:waypoint xsi:type="dc:Point" x="595.0" y="230.0"/>
                    <di:waypoint xsi:type="dc:Point" x="595.0" y="245.0"/>
                    <di:waypoint xsi:type="dc:Point" x="595.0" y="260.0"/>
                    <bpmndi:BPMNLabel id="BPMNLabel_21"/>
                </bpmndi:BPMNEdge>
            </bpmndi:BPMNPlane>
        </bpmndi:BPMNDiagram>
    </xsl:template>
</xsl:stylesheet>
