package xslt;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author SERG Development
 */
import java.io.*;
import javax.xml.transform.*;
import javax.xml.transform.stream.*;

public class Transformasi {
    // This method applies the xslFilename to inFilename and writes
    // the output to outFilename.
    public static void xsl(String inFilename, String outFilename, String xslFilename) {
        try {
            // Create transformer factory
            TransformerFactory factory = TransformerFactory.newInstance();

            // Use the factory to create a template containing the xsl file
            Templates template = factory.newTemplates(new StreamSource(
                new FileInputStream(xslFilename)));

            // Use the template to create a transformer
            Transformer xformer = template.newTransformer();

            // Prepare the input and output files
            Source source = new StreamSource(new FileInputStream(inFilename));
            Result result = new StreamResult(new FileOutputStream(outFilename));

            // Apply the xsl file to the source file and write the result
            // to the output file
            xformer.transform(source, result);
        } catch (FileNotFoundException | TransformerConfigurationException e) {
        }
        // An error occurred in the XSL file
         catch (TransformerException e) {
            // An error occurred while applying the XSL file
            // Get location of error in input file
            SourceLocator locator = e.getLocator();
            int col = locator.getColumnNumber();
            int line = locator.getLineNumber();
            String publicId = locator.getPublicId();
            String systemId = locator.getSystemId();
        }
    }
    public static void main (String [] args){
        String inFilename="C:\\Users\\SERG Development\\Documents\\NetBeansProjects\\thesis\\AML2BPMI\\src\\xslt\\data\\aml.xml";
        String xslFilename="C:\\Users\\SERG Development\\Documents\\NetBeansProjects\\thesis\\AML2BPMI\\src\\xslt\\data\\AML2BPMI.xsl";
        String outFilename="C:\\Users\\SERG Development\\Documents\\NetBeansProjects\\thesis\\AML2BPMI\\src\\xslt\\data\\out.xml";
        Transformasi.xsl(inFilename, outFilename, xslFilename);
    }
}
