package apm.common.utils;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics2D;
import java.awt.GraphicsEnvironment;
import java.awt.Image;
import java.awt.geom.Rectangle2D;
import java.awt.image.BufferedImage;
import java.io.BufferedOutputStream;
import java.io.BufferedWriter;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.imageio.ImageIO;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.hslf.model.Slide;
import org.apache.poi.hslf.model.TextRun;
import org.apache.poi.hslf.usermodel.RichTextRun;
import org.apache.poi.hslf.usermodel.SlideShow;
import org.apache.poi.hssf.converter.ExcelToHtmlConverter;
import org.apache.poi.hssf.usermodel.HSSFClientAnchor;
import org.apache.poi.hssf.usermodel.HSSFComment;
import org.apache.poi.hssf.usermodel.HSSFPatriarch;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hwpf.HWPFDocument;
import org.apache.poi.hwpf.converter.PicturesManager;
import org.apache.poi.hwpf.converter.WordToHtmlConverter;
import org.apache.poi.hwpf.usermodel.Picture;
import org.apache.poi.hwpf.usermodel.PictureType;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xslf.usermodel.XMLSlideShow;
import org.apache.poi.xslf.usermodel.XSLFShape;
import org.apache.poi.xslf.usermodel.XSLFSlide;
import org.apache.poi.xslf.usermodel.XSLFTextParagraph;
import org.apache.poi.xslf.usermodel.XSLFTextRun;
import org.apache.poi.xslf.usermodel.XSLFTextShape;
import org.apache.poi.xssf.usermodel.XSSFComment;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.poi.xwpf.converter.core.FileImageExtractor;
import org.apache.poi.xwpf.converter.core.FileURIResolver;
import org.apache.poi.xwpf.converter.xhtml.XHTMLConverter;
import org.apache.poi.xwpf.converter.xhtml.XHTMLOptions;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.w3c.dom.Document;

import com.google.common.collect.BiMap;
import com.google.common.collect.HashBiMap;

public class OfficeUtils{
	
	public static final int DEFAULT_WIDTH = 800;
    public static final int DEFAULT_HEIGHT = 600;
    private static int index;
    private static Dimension pgsize;
    private static BufferedImage img;
    
	/**
	 * 判断是何种文档需要转换成html
	 * @param srcPath
	 * @param desPath
	 * @param fileId
	 * @return 
	 * @throws IOException 
	 * @throws ParserConfigurationException 
	 * @throws TransformerException 
	 * @throws InvalidFormatException 
	 */
	public static List<String> convert2Html(String srcPath, String desPath, String fileId) throws IOException, TransformerException, ParserConfigurationException, InvalidFormatException{
		//得到文件后缀名
		String suf = getExtension(srcPath);
		if(StringUtils.isNotBlank(suf)){
			if(".doc".equals(suf)){
				doc2Html(srcPath, desPath, fileId);
			}else if(".docx".equals(suf)){
				docx2Html(srcPath, desPath, fileId);
			}else if(".xls".equals(suf)){
				excel2Html(srcPath, desPath);
			}else if(".xlsx".equals(suf)){
				//如果为xlsx文件,则先转化为xls文件
				//转化之后的文件名
				String realSrcFile =  srcPath.substring(0, srcPath.lastIndexOf(".")) + ".xls";
				System.out.println(realSrcFile);
				//转化
				xlsx2xls_progress(srcPath, realSrcFile);
				//判断是否已成功
				File f = new File(realSrcFile);
				if(f.exists() && !f.isDirectory()){
					excel2Html(realSrcFile, desPath);
				}
				//成功之后删除
				f.delete();
			}else if(".ppt".equals(suf)){ //ppt 
				return ppt2Html(srcPath, desPath, fileId);
			}else if(".pptx".equals(suf)){
				return pptx2Html(srcPath, desPath, fileId);
			}
		}
		return null;
	}
	
	/**
	 * .doc文件生成html页面
	 * @param srcPath
	 * @param outPutFile
	 * @throws TransformerException
	 * @throws IOException
	 * @throws ParserConfigurationException
	 */
	 public static void doc2Html(String srcPath, String outPutFile, final String fileId)
			throws TransformerException, IOException,
			ParserConfigurationException {
		//源文件
		File outFile = new  File(outPutFile);
		HWPFDocument wordDocument = new HWPFDocument(new FileInputStream(srcPath));// WordToHtmlUtils.loadDoc(new// FileInputStream(inputFile));
		WordToHtmlConverter wordToHtmlConverter = new WordToHtmlConverter(DocumentBuilderFactory.newInstance().newDocumentBuilder().newDocument());
		wordToHtmlConverter.setPicturesManager(new PicturesManager() {
			public String savePicture(byte[] content, PictureType pictureType,String suggestedName, float widthInches, float heightInches) {
				return fileId + "/" + suggestedName;
			}
		});
		wordToHtmlConverter.processDocument(wordDocument);
		// save pictures
		List<Picture> pics = wordDocument.getPicturesTable().getAllPictures();
		//存放图片的路径
		String imgPath = outFile.getParentFile().getPath() + File.separator + fileId ;
		File imgF = new File(imgPath);
		if(!imgF.exists() || !imgF.isDirectory()){
			imgF.mkdirs();
		}
		System.out.println("imgPath ------ "+ imgPath);
		if (pics != null) {
			for (int i = 0; i < pics.size(); i++) {
				Picture pic = (Picture) pics.get(i);
				try {
					FileOutputStream  fs = new FileOutputStream(imgPath + File.separator + pic.suggestFullFileName());
					pic.writeImageContent(fs);
					fs.close();
				} catch (FileNotFoundException e) {
					e.printStackTrace();
				}
			}
		}
		Document htmlDocument = wordToHtmlConverter.getDocument();
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		DOMSource domSource = new DOMSource(htmlDocument);
		StreamResult streamResult = new StreamResult(out);

		TransformerFactory tf = TransformerFactory.newInstance();
		Transformer serializer = tf.newTransformer();
		serializer.setOutputProperty(OutputKeys.ENCODING, "utf-8");
		serializer.setOutputProperty(OutputKeys.INDENT, "yes");
		serializer.setOutputProperty(OutputKeys.METHOD, "html");
		serializer.transform(domSource, streamResult);
		out.close();
		writeFile(new String(out.toByteArray()), outPutFile);
	} 
    
	/**
	 * 读入文件
	 * @param content
	 * @param path
	 */
	public static void writeFile(String content, String path) {
		FileOutputStream fos = null;
		BufferedWriter bw = null;
		try {
			File file = new File(path);
			fos = new FileOutputStream(file);
			bw = new BufferedWriter(new OutputStreamWriter(fos, "utf-8"));
			bw.write(content);
		} catch (FileNotFoundException fnfe) {
			fnfe.printStackTrace();
		} catch (IOException ioe) {
			ioe.printStackTrace();
		} finally {
			try {
				if (bw != null)
					bw.close();
				if (fos != null)
					fos.close();
			} catch (IOException ie) {
			}
		}
	}

	/**
	 * .docx文件生成html页面
	 * @param srcPath
	 * @param outputFile
	 * @throws IOException
	 */
	/*public static void doGenerateSysOut(String fileInName) throws IOException {
		long startTime = System.currentTimeMillis();
		XWPFDocument document = new XWPFDocument(new FileInputStream(fileInName));

		XHTMLOptions options = XHTMLOptions.create().indent(4);
		OutputStream out = System.out;
		XHTMLConverter.getInstance().convert(document, out, options);

		System.err.println("Elapsed time=" + (System.currentTimeMillis() - startTime) + "(ms)");
	}*/

	public static void docx2Html(String srcPath, String outputFile, String fileId) throws IOException {
		File f = new File(outputFile);
		XWPFDocument document = new XWPFDocument(new FileInputStream(srcPath));
		XHTMLOptions options = XHTMLOptions.create();// .indent( 4 );
		//获取存放图片的地址
		String imgPath = f.getParentFile().getPath() + File.separator + fileId;
		File imgF = new File(imgPath);
		if(!imgF.exists() || !imgF.isDirectory()){
			imgF.mkdirs();
		}
		options.setExtractor(new FileImageExtractor(imgF));
		// URI resolver
		options.URIResolver(new FileURIResolver(imgF));
		OutputStream out = new FileOutputStream(new File(outputFile));
		XHTMLConverter.getInstance().convert(document, out, options);
	}
	
	public static void doGenerateHTMLFile(String fileInName, String outputFile) throws IOException {
			long startTime = System.currentTimeMillis();
			XWPFDocument document = new XWPFDocument(new FileInputStream(fileInName));
			XHTMLOptions options = XHTMLOptions.create();// .indent( 4 );
			// Extract image
			File imageFolder = new File("d:/docx");
			options.setExtractor(new FileImageExtractor(imageFolder));
			// URI resolver
			options.URIResolver(new FileURIResolver(imageFolder));

			OutputStream out = new FileOutputStream(new File(outputFile));
			XHTMLConverter.getInstance().convert(document, out, options);

			System.out.println("Generate " + outputFile + " with "	+ (System.currentTimeMillis() - startTime) + " ms.");
		}
	
	/**
	 * .xls文件生成html页面
	 * @param excelFilePath
	 * @param htmlFilePath
	 * @throws IOException
	 * @throws ParserConfigurationException
	 * @throws TransformerException
	 */
	public static void excel2Html(String excelFilePath,String htmlFilePath)  
		    throws IOException,ParserConfigurationException,TransformerException  
		    {  
		        File excelFile = new File(excelFilePath);  
		        File htmlFile = new File(htmlFilePath);  
		        File htmlFileParent = new File(htmlFile.getParent());  
		        InputStream is = null;  
		        OutputStream out = null;  
		        StringWriter writer = null;  
		        try{  
		            if(excelFile.exists()){  
		                if(!htmlFileParent.exists()){  
		                    htmlFileParent.mkdirs();  
		                }  
		                is = new FileInputStream(excelFile);  
		                HSSFWorkbook workBook = new HSSFWorkbook(is);  
		                
		                ExcelToHtmlConverter converter = new ExcelToHtmlConverter(DocumentBuilderFactory.newInstance().newDocumentBuilder().newDocument());  
		                converter.processWorkbook(workBook);  
		                  
		                writer = new StringWriter();  
		                Transformer serializer = TransformerFactory.newInstance().newTransformer();  
		                serializer.setOutputProperty(OutputKeys.ENCODING, "UTF-8");  
		                serializer.setOutputProperty(OutputKeys.INDENT, "yes");  
		                serializer.setOutputProperty(OutputKeys.METHOD, "html");  
		                serializer.transform(  
		                        new DOMSource(converter.getDocument()),  
		                        new StreamResult(writer) );  
		                out = new FileOutputStream(htmlFile);  
		                out.write(writer.toString().getBytes("UTF-8"));  
		                out.flush();  
		                out.close();  
		                writer.close();  
		            }  
		        }finally{  
		            try{  
		                if(is != null){  
		                    is.close();  
		                }  
		                if(out != null){  
		                    out.close();  
		                }  
		                if(writer != null){  
		                    writer.close();  
		                }  
		            }catch(IOException e){  
		                e.printStackTrace();  
		            }  
		        }  
		    }  
	
	/**
	 * ppt转成html页面
	 * @param srcPath, desPath, fielId
	 *        源文件 , 目标文件, ppt文件id
	 * @throws IOException 
	 */
	 public static List<String>  ppt2Html(String srcPath, String desPath, String fileId) throws IOException{
		  FileInputStream is = new FileInputStream(srcPath);
	        SlideShow ppt = new SlideShow(is);
	        is.close();
	        pgsize = ppt.getPageSize();
	        //用来存在所有图片生成的路径
	        List<String> paths = new ArrayList<String>();
	        Slide[] slide = ppt.getSlides();
	        for (index = 0; index < slide.length; index++) {
	            drawPPTSlide(slide[index], desPath, index, fileId, paths);
	        }
	        return paths;
	}
	
	 private static void drawPPTSlide(Slide slide, String desPath, int i, String fileId, List<String> path) throws IOException {
	        setFont(slide);
	        Graphics2D graphics = createGraphics2D();
	        slide.draw(graphics);
	        drawPng(desPath, i, fileId, path);
	    }
	 
	 private static void setFont(Slide slide) {
	        TextRun[] truns = slide.getTextRuns();
	        for (TextRun trun : truns) {
	            RichTextRun[] rtruns = trun.getRichTextRuns();
	            for (RichTextRun rtrun : rtruns) {
	                if (!isSupport(rtrun.getFontName())) {
	                    rtrun.setFontIndex(1);
	                    rtrun.setFontName("宋体");
	                }
	            }
	        }
	    }
	 
	 private static Graphics2D createGraphics2D() {
		    img = new BufferedImage(pgsize.width, pgsize.height, BufferedImage.TYPE_INT_RGB);
	        Graphics2D graphics = img.createGraphics();
	        graphics.setPaint(Color.white);
	        graphics.fill(new Rectangle2D.Float(0, 0, pgsize.width, pgsize.height));
	        return graphics;
	    }
	 
	 private static void drawPng(String desPath, int index, String fileId, List<String> path) throws IOException {
		 String paths = desPath + "/" + fileId + "_" + index + ".jpg";
		 System.out.println(paths);
		 //保存至集合中
		 path.add(paths);
		 mkDir(new File(desPath));
		 saveImage(paths);
	       /* if (index == 0) {
	            drawSmall();
	        }*/
	      img = null;
	    }
	 
	 private static void saveImage(String pngPatch) throws IOException  {
		    Image smallImg = img.getScaledInstance(DEFAULT_WIDTH, DEFAULT_HEIGHT, Image.SCALE_SMOOTH);
	        img = new BufferedImage(DEFAULT_WIDTH, DEFAULT_HEIGHT, BufferedImage.TYPE_INT_RGB);
	        Graphics2D g = img.createGraphics();
	        g.drawImage(smallImg, 0, 0, null);
	        g.dispose();
	        OutputStream out = new FileOutputStream(pngPatch);
	        ImageIO.write(img, "jpg", out);
	        out.close();
	    }
	 
	  /**
		 * pptx转成html页面
		 * @param srcPath
		 * @param desPath
	     * @throws IOException 
		 */ 
		public static List<String> pptx2Html(String srcPath, String desPath, String fileId) throws IOException{
			FileInputStream is = new FileInputStream(srcPath);
	        XMLSlideShow ppt = new XMLSlideShow(is);
	        is.close();
	        //保存图片的路径
	        List<String> list = new ArrayList<String>();
	        pgsize = ppt.getPageSize();
	        XSLFSlide[] slide = ppt.getSlides();
	        for (int i = 0; i < slide.length; i++) {
	            drawPPTX(slide[i], desPath, i, fileId, list);
	        }
	        return list;
		}
		
		private static void drawPPTX(XSLFSlide slide, String desPath, int index, String fileId, List<String> paths) throws IOException {
	        Graphics2D graphics = createGraphics2D();
	        setFont(slide);
	        slide.draw(graphics);
	        drawPng(desPath, index, fileId, paths);
	    }
	 
		  private static void setFont(XSLFSlide slide) {
		        for (XSLFShape shape : slide.getShapes()) {
		            if (shape instanceof XSLFTextShape) {
		                for (XSLFTextParagraph paragraph : ((XSLFTextShape) shape)) {
		                    List<XSLFTextRun> truns = paragraph.getTextRuns();
		                    for (XSLFTextRun trun : truns) {
		                        if (!isSupport(trun.getFontFamily())) {
		                            trun.setFontFamily("宋体");
		                        }
		                    }
		                }
		            }
	
		        }
		    } 
	

    public static String getFileName(String fileName) {
        int pos = fileName.lastIndexOf(".");
        if (pos >= 0) {
            return fileName.substring(0, pos);
        } else {
            return fileName;
        }
    }

    public static void mkDir(File file) {
        if (file.exists()) {
            return;
        }
        if (!file.mkdir()) {
        	 System.out.println("mkdir failed" + file.getAbsolutePath());
        }
    }
    public static String getExtension(String fileName) {
        int pos = fileName.lastIndexOf(".");
        if (pos >= 0) {
            return fileName.substring(pos);
        } else {
            return "";
        }
    }
	 
	 private static final Set<String> SUPPORT_FONT = new HashSet<>();
	 private static final BiMap<String, String> EN_TO_CN_KNOWN_FONT = HashBiMap.create();
	    static {
	        EN_TO_CN_KNOWN_FONT.put("HYA0GJ", "汉仪超粗宋简");
	        EN_TO_CN_KNOWN_FONT.put("HYA0GF", "汉仪超粗宋繁");
	        EN_TO_CN_KNOWN_FONT.put("HYA1GJ", "汉仪书宋一简");
	        EN_TO_CN_KNOWN_FONT.put("HYA1GF", "汉仪书宋一繁");
	        EN_TO_CN_KNOWN_FONT.put("HYA2GJ", "汉仪报宋简");
	        EN_TO_CN_KNOWN_FONT.put("HYA2GF", "汉仪报宋繁");
	        EN_TO_CN_KNOWN_FONT.put("HYA3GJ", "汉仪中宋简");
	        EN_TO_CN_KNOWN_FONT.put("HYA3GF", "汉仪中宋繁");
	        EN_TO_CN_KNOWN_FONT.put("HYA4GJ", "汉仪大宋简");
	        EN_TO_CN_KNOWN_FONT.put("HYA4GF", "汉仪大宋繁");
	        EN_TO_CN_KNOWN_FONT.put("HYA5GJ", "汉仪长宋简");
	        EN_TO_CN_KNOWN_FONT.put("HYA5GF", "汉仪长宋繁");
	        EN_TO_CN_KNOWN_FONT.put("HYA6GJ", "汉仪书宋二简");
	        EN_TO_CN_KNOWN_FONT.put("HYA6GF", "汉仪书宋二繁");
	        EN_TO_CN_KNOWN_FONT.put("HYA7GJ", "汉仪字典宋简");
	        EN_TO_CN_KNOWN_FONT.put("HYA7GF", "汉仪字典宋繁");
	        EN_TO_CN_KNOWN_FONT.put("HYA9GJ", "汉仪粗宋简");
	        EN_TO_CN_KNOWN_FONT.put("HYA9GF", "汉仪粗宋繁");
	        EN_TO_CN_KNOWN_FONT.put("HYB0GJ", "汉仪超粗黑简");
	        EN_TO_CN_KNOWN_FONT.put("HYB0GF", "汉仪超粗黑繁");
	        EN_TO_CN_KNOWN_FONT.put("HYB1GJ", "汉仪中黑简");
	        EN_TO_CN_KNOWN_FONT.put("HYB1GF", "汉仪中黑繁");
	        EN_TO_CN_KNOWN_FONT.put("HYB2GJ", "汉仪大黑简");
	        EN_TO_CN_KNOWN_FONT.put("HYB2GF", "汉仪大黑繁");
	        EN_TO_CN_KNOWN_FONT.put("HYB3GJ", "汉仪长美黑简");
	        EN_TO_CN_KNOWN_FONT.put("HYB3GF", "汉仪长美黑繁");
	        EN_TO_CN_KNOWN_FONT.put("HYB4GJ", "汉仪方叠体简");
	        EN_TO_CN_KNOWN_FONT.put("HYB4GF", "汉仪方叠体繁");
	        EN_TO_CN_KNOWN_FONT.put("HYB5GJ", "汉仪醒示体简");
	        EN_TO_CN_KNOWN_FONT.put("HYB5GF", "汉仪醒示体繁");
	        EN_TO_CN_KNOWN_FONT.put("HYB6GJ", "汉仪长艺体简");
	        EN_TO_CN_KNOWN_FONT.put("HYB6GF", "汉仪长艺体繁");
	        EN_TO_CN_KNOWN_FONT.put("HYB7GJ", "汉仪双线体简");
	        EN_TO_CN_KNOWN_FONT.put("HYB7GF", "汉仪双线体繁");
	        EN_TO_CN_KNOWN_FONT.put("HYB8GJ", "汉仪圆叠体简");
	        EN_TO_CN_KNOWN_FONT.put("HYB8GF", "汉仪圆叠体繁");
	        EN_TO_CN_KNOWN_FONT.put("HYB9GJ", "汉仪粗黑简");
	        EN_TO_CN_KNOWN_FONT.put("HYB9GF", "汉仪粗黑繁");
	        EN_TO_CN_KNOWN_FONT.put("HYC1GJ", "汉仪楷体简");
	        EN_TO_CN_KNOWN_FONT.put("HYC1GF", "汉仪楷体繁");
	        EN_TO_CN_KNOWN_FONT.put("HYC3GJ", "汉仪中楷简");
	        EN_TO_CN_KNOWN_FONT.put("HYD1GJ", "汉仪仿宋简");
	        EN_TO_CN_KNOWN_FONT.put("HYD1GF", "汉仪仿宋繁");
	        EN_TO_CN_KNOWN_FONT.put("HYD4GJ", "汉仪粗仿宋简");
	        EN_TO_CN_KNOWN_FONT.put("HYE1GJ", "汉仪细圆简");
	        EN_TO_CN_KNOWN_FONT.put("HYE1GF", "汉仪细圆繁");
	        EN_TO_CN_KNOWN_FONT.put("HYE2GJ", "汉仪细中圆简");
	        EN_TO_CN_KNOWN_FONT.put("HYE2GF", "汉仪细中圆繁");
	        EN_TO_CN_KNOWN_FONT.put("HYE3GJ", "汉仪中圆简");
	        EN_TO_CN_KNOWN_FONT.put("HYE3GF", "汉仪中圆繁");
	        EN_TO_CN_KNOWN_FONT.put("HYE4GJ", "汉仪粗圆简");
	        EN_TO_CN_KNOWN_FONT.put("HYE4GF", "汉仪粗圆繁");
	        EN_TO_CN_KNOWN_FONT.put("HYE0GJ", "汉仪超粗圆简");
	        EN_TO_CN_KNOWN_FONT.put("HYF1GJ", "汉仪大隶书简");
	        EN_TO_CN_KNOWN_FONT.put("HYF1GF", "汉仪大隶书繁");
	        EN_TO_CN_KNOWN_FONT.put("HYF2GJ", "汉仪小隶书简");
	        EN_TO_CN_KNOWN_FONT.put("HYF2GF", "汉仪小隶书繁");
	        EN_TO_CN_KNOWN_FONT.put("HYF3GJ", "汉仪中隶书简");
	        EN_TO_CN_KNOWN_FONT.put("HYF3GF", "汉仪中隶书繁");
	        EN_TO_CN_KNOWN_FONT.put("HYF0GJ", "汉仪方隶简");
	        EN_TO_CN_KNOWN_FONT.put("HYG6GJ", "汉仪特细等线简");
	        EN_TO_CN_KNOWN_FONT.put("HYG1GJ", "汉仪细等线简");
	        EN_TO_CN_KNOWN_FONT.put("HYG1GF", "汉仪细等线繁");
	        EN_TO_CN_KNOWN_FONT.put("HYG2GJ", "汉仪中等线简");
	        EN_TO_CN_KNOWN_FONT.put("HYG2GF", "汉仪中等线繁");
	        EN_TO_CN_KNOWN_FONT.put("HYH1GJ", "汉仪魏碑简");
	        EN_TO_CN_KNOWN_FONT.put("HYH1GF", "汉仪魏碑繁");
	        EN_TO_CN_KNOWN_FONT.put("HYH3GJ", "汉仪书魂体简");
	        EN_TO_CN_KNOWN_FONT.put("HYH4GJ", "汉仪南宫体简");
	        EN_TO_CN_KNOWN_FONT.put("HYI1GJ", "汉仪行楷简");
	        EN_TO_CN_KNOWN_FONT.put("HYI1GF", "汉仪行楷繁");
	        EN_TO_CN_KNOWN_FONT.put("HYI2GJ", "汉仪细行楷简");
	        EN_TO_CN_KNOWN_FONT.put("HYI3GJ", "汉仪瘦金书简");
	        EN_TO_CN_KNOWN_FONT.put("HYI3GF", "汉仪瘦金书繁");
	        EN_TO_CN_KNOWN_FONT.put("HYK1GJ", "汉仪综艺体简");
	        EN_TO_CN_KNOWN_FONT.put("HYK1GF", "汉仪综艺体繁");
	        EN_TO_CN_KNOWN_FONT.put("HYK2GJ", "汉仪菱心体简");
	        EN_TO_CN_KNOWN_FONT.put("HYL1GJ", "汉仪彩云体简");
	        EN_TO_CN_KNOWN_FONT.put("HYL1GF", "汉仪彩云体繁");
	        EN_TO_CN_KNOWN_FONT.put("HYM1GJ", "汉仪咪咪体简");
	        EN_TO_CN_KNOWN_FONT.put("HYM1GF", "汉仪咪咪体繁");
	        EN_TO_CN_KNOWN_FONT.put("HYM2GJ", "汉仪黑咪体简");
	        EN_TO_CN_KNOWN_FONT.put("HYM2GF", "汉仪黑咪体繁");
	        EN_TO_CN_KNOWN_FONT.put("HYN1GJ", "汉仪舒同体简");
	        EN_TO_CN_KNOWN_FONT.put("HYN1GF", "汉仪舒同体繁");
	        EN_TO_CN_KNOWN_FONT.put("HYO1GJ", "汉仪琥珀体简");
	        EN_TO_CN_KNOWN_FONT.put("HYO1GF", "汉仪琥珀体繁");
	        EN_TO_CN_KNOWN_FONT.put("HYP1GJ", "汉仪水滴体简");
	        EN_TO_CN_KNOWN_FONT.put("HYP1GF", "汉仪水滴体繁");
	        EN_TO_CN_KNOWN_FONT.put("HYQ1GJ", "汉仪竹节体简");
	        EN_TO_CN_KNOWN_FONT.put("HYQ1GF", "汉仪竹节体繁");
	        EN_TO_CN_KNOWN_FONT.put("HYQ2GJ", "汉仪火柴体简");
	        EN_TO_CN_KNOWN_FONT.put("HYR1GJ", "汉仪凌波体简");
	        EN_TO_CN_KNOWN_FONT.put("HYR1GF", "汉仪凌波体繁");
	        EN_TO_CN_KNOWN_FONT.put("HYR2GJ", "汉仪漫步体简");
	        EN_TO_CN_KNOWN_FONT.put("HYR2GF", "汉仪漫步体繁");
	        EN_TO_CN_KNOWN_FONT.put("HYX4GF", "汉仪颜楷繁");
	        EN_TO_CN_KNOWN_FONT.put("HYY1GJ", "汉仪秀英体简");
	        EN_TO_CN_KNOWN_FONT.put("HYY1GF", "汉仪秀英体繁");
	        EN_TO_CN_KNOWN_FONT.put("HYF4GJ", "汉仪雁翎体简");
	        EN_TO_CN_KNOWN_FONT.put("HYX1GJ", "汉仪橄榄体简");
	        EN_TO_CN_KNOWN_FONT.put("HYX1GF", "汉仪橄榄体繁");
	        EN_TO_CN_KNOWN_FONT.put("HYF5GJ", "汉仪陈频破体简");
	        EN_TO_CN_KNOWN_FONT.put("HYF9GJ", "汉仪花蝶体简");
	        EN_TO_CN_KNOWN_FONT.put("HYG3GJ", "汉仪丫丫体简");
	        EN_TO_CN_KNOWN_FONT.put("HYG4GJ", "汉仪清韵体简");
	        EN_TO_CN_KNOWN_FONT.put("HYI4GJ", "汉仪雪君体简");
	        EN_TO_CN_KNOWN_FONT.put("HYI4GF", "汉仪雪君体繁");
	        EN_TO_CN_KNOWN_FONT.put("HYJ2GJ", "汉仪娃娃篆简");
	        EN_TO_CN_KNOWN_FONT.put("HYJ1GF", "汉仪篆书繁");
	        EN_TO_CN_KNOWN_FONT.put("HYJ3GF", "汉仪粗篆繁");
	        EN_TO_CN_KNOWN_FONT.put("HYH2GJ", "汉仪神工体简");
	        EN_TO_CN_KNOWN_FONT.put("HYJ4GJ", "汉仪柏青体简");
	        EN_TO_CN_KNOWN_FONT.put("HYJ4GF", "汉仪柏青体繁");
	        EN_TO_CN_KNOWN_FONT.put("HYK3GJ", "汉仪海韵体简");
	        EN_TO_CN_KNOWN_FONT.put("HYK5GJ", "汉仪彩蝶体简");
	        EN_TO_CN_KNOWN_FONT.put("HYM4GJ", "汉仪哈哈体简");
	        EN_TO_CN_KNOWN_FONT.put("HYM5GJ", "汉仪白棋体简");
	        EN_TO_CN_KNOWN_FONT.put("HYM6GJ", "汉仪黑棋体简");
	        EN_TO_CN_KNOWN_FONT.put("HYM7GJ", "汉仪水波体简");
	        EN_TO_CN_KNOWN_FONT.put("HYN3GJ", "汉仪蝶语体简");
	        EN_TO_CN_KNOWN_FONT.put("HYO3GJ", "汉仪太极体简");
	        EN_TO_CN_KNOWN_FONT.put("HYR3GJ", "汉仪黛玉体简");
	        EN_TO_CN_KNOWN_FONT.put("HYT4GJ", "汉仪立黑简");
	        EN_TO_CN_KNOWN_FONT.put("HYY2GJ", "汉仪萝卜体简");
	        EN_TO_CN_KNOWN_FONT.put("HYY4GJ", "汉仪嘟嘟体简");
	        EN_TO_CN_KNOWN_FONT.put("HYD2GJ", "汉仪家书简");
	        EN_TO_CN_KNOWN_FONT.put("HYD2GF", "汉仪家书繁");
	        EN_TO_CN_KNOWN_FONT.put("HYO2GJ", "汉仪雪峰体简");
	        EN_TO_CN_KNOWN_FONT.put("HYO2GF", "汉仪雪峰体繁");
	        EN_TO_CN_KNOWN_FONT.put("PMingLiU", "新細明體");
	        EN_TO_CN_KNOWN_FONT.put("MingLiU", "細明體");
	        EN_TO_CN_KNOWN_FONT.put("DFKai-SB", "標楷體");
	        EN_TO_CN_KNOWN_FONT.put("SimHei", "黑体");
	        EN_TO_CN_KNOWN_FONT.put("SimSun", "宋体");
	        EN_TO_CN_KNOWN_FONT.put("NSimSun", "新宋体");
	        EN_TO_CN_KNOWN_FONT.put("FangSong", "仿宋");
	        EN_TO_CN_KNOWN_FONT.put("KaiTi", "楷体");
	        EN_TO_CN_KNOWN_FONT.put("FangSong_GB2312", "仿宋_GB2312");
	        EN_TO_CN_KNOWN_FONT.put("KaiTi_GB2312", "楷体_GB2312");
	        EN_TO_CN_KNOWN_FONT.put("Microsoft JhengHei", "微軟正黑體");
	        EN_TO_CN_KNOWN_FONT.put("Microsoft YaHei", "微软雅黑体");
	        EN_TO_CN_KNOWN_FONT.put("LiSu", "隶书");
	        EN_TO_CN_KNOWN_FONT.put("YouYuan", "幼圆");
	        EN_TO_CN_KNOWN_FONT.put("STXihei", "华文细黑");
	        EN_TO_CN_KNOWN_FONT.put("STKaiti", "华文楷体");
	        EN_TO_CN_KNOWN_FONT.put("STSong", "华文宋体");
	        EN_TO_CN_KNOWN_FONT.put("STZhongsong", "华文中宋");
	        EN_TO_CN_KNOWN_FONT.put("STFangsong", "华文仿宋");
	        EN_TO_CN_KNOWN_FONT.put("FZShuTi", "方正舒体");
	        EN_TO_CN_KNOWN_FONT.put("FZYaoti", "方正姚体");
	        EN_TO_CN_KNOWN_FONT.put("STCaiyun", "华文彩云");
	        EN_TO_CN_KNOWN_FONT.put("STHupo", "华文琥珀");
	        EN_TO_CN_KNOWN_FONT.put("STLiti", "华文隶书");
	        EN_TO_CN_KNOWN_FONT.put("STXingkai", "华文行楷");
	        EN_TO_CN_KNOWN_FONT.put("STXinwei", "华文新魏");
	        EN_TO_CN_KNOWN_FONT.put("FZBaoSong-Z04S", "方正报宋简体");
	        EN_TO_CN_KNOWN_FONT.put("FZCuYuan-M03S", "方正粗圆简体");
	        EN_TO_CN_KNOWN_FONT.put("FZDaBiaoSong-B06S", "方正大标宋简体");
	        EN_TO_CN_KNOWN_FONT.put("FZDaHei-B02S", "方正大黑简体");
	        EN_TO_CN_KNOWN_FONT.put("FZFangSong-Z02S", "方正仿宋简体");
	        EN_TO_CN_KNOWN_FONT.put("FZHei-B01S", "方正黑体简体");
	        EN_TO_CN_KNOWN_FONT.put("FZHuPo-M04S", "方正琥珀简体");
	        EN_TO_CN_KNOWN_FONT.put("FZKai-Z03S", "方正楷体简体");
	        EN_TO_CN_KNOWN_FONT.put("FZLiBian-S02S", "方正隶变简体");
	        EN_TO_CN_KNOWN_FONT.put("FZLiShu-S01S", "方正隶书简体");
	        EN_TO_CN_KNOWN_FONT.put("FZMeiHei-M07S", "方正美黑简体");
	        EN_TO_CN_KNOWN_FONT.put("FZShuSong-Z01S", "方正书宋简体");
	        EN_TO_CN_KNOWN_FONT.put("FZShuTi-S05S", "方正舒体简体");
	        EN_TO_CN_KNOWN_FONT.put("FZShuiZhu-M08S", "方正水柱简体");
	        EN_TO_CN_KNOWN_FONT.put("FZSongHei-B07S", "方正宋黑简体");
	        EN_TO_CN_KNOWN_FONT.put("FZSong", "方正宋三简体");
	        EN_TO_CN_KNOWN_FONT.put("FZWeiBei-S03S", "方正魏碑简体");
	        EN_TO_CN_KNOWN_FONT.put("FZXiDengXian-Z06S", "方正细等线简体");
	        EN_TO_CN_KNOWN_FONT.put("FZXiHei", "方正细黑一简体");
	        EN_TO_CN_KNOWN_FONT.put("FZXiYuan-M01S", "方正细圆简体");
	        EN_TO_CN_KNOWN_FONT.put("FZXiaoBiaoSong-B05S", "方正小标宋简体");
	        EN_TO_CN_KNOWN_FONT.put("FZXingKai-S04S", "方正行楷简体");
	        EN_TO_CN_KNOWN_FONT.put("FZYaoTi-M06S", "方正姚体简体");
	        EN_TO_CN_KNOWN_FONT.put("FZZhongDengXian-Z07S", "方正中等线简体");
	        EN_TO_CN_KNOWN_FONT.put("FZZhunYuan-M02S", "方正准圆简体");
	        EN_TO_CN_KNOWN_FONT.put("FZZongYi-M05S", "方正综艺简体");
	        EN_TO_CN_KNOWN_FONT.put("FZCaiYun-M09S", "方正彩云简体");
	        EN_TO_CN_KNOWN_FONT.put("FZLiShu", "方正隶二简体");
	        EN_TO_CN_KNOWN_FONT.put("FZKangTi-S07S", "方正康体简体");
	        EN_TO_CN_KNOWN_FONT.put("FZChaoCuHei-M10S", "方正超粗黑简体");
	        EN_TO_CN_KNOWN_FONT.put("FZNew", "方正新报宋简体");
	        EN_TO_CN_KNOWN_FONT.put("FZNew", "方正新舒体简体");
	        EN_TO_CN_KNOWN_FONT.put("FZHuangCao-S09S", "方正黄草简体");
	        EN_TO_CN_KNOWN_FONT.put("FZShaoEr-M11S", "方正少儿简体");
	        EN_TO_CN_KNOWN_FONT.put("FZZhiYi-M12S", "方正稚艺简体");
	        EN_TO_CN_KNOWN_FONT.put("FZXiShanHu-M13S", "方正细珊瑚简体");
	        EN_TO_CN_KNOWN_FONT.put("FZCuSong-B09S", "方正粗宋简体");
	        EN_TO_CN_KNOWN_FONT.put("FZPingHe-S11S", "方正平和简体");
	        EN_TO_CN_KNOWN_FONT.put("FZHuaLi-M14S", "方正华隶简体");
	        EN_TO_CN_KNOWN_FONT.put("FZShouJinShu-S10S", "方正瘦金书简体");
	        EN_TO_CN_KNOWN_FONT.put("FZXiQian-M15S", "方正细倩简体");
	        EN_TO_CN_KNOWN_FONT.put("FZZhongQian-M16S", "方正中倩简体");
	        EN_TO_CN_KNOWN_FONT.put("FZCuQian-M17S", "方正粗倩简体");
	        EN_TO_CN_KNOWN_FONT.put("FZPangWa-M18S", "方正胖娃简体");
	        EN_TO_CN_KNOWN_FONT.put("FZSongYi-Z13S", "方正宋一简体");
	        EN_TO_CN_KNOWN_FONT.put("FZBaoSong-Z04T", "方正报宋繁体");
	        EN_TO_CN_KNOWN_FONT.put("FZCaiYun-M09T", "方正彩云繁体");
	        EN_TO_CN_KNOWN_FONT.put("FZChaoCuHei-M10T", "方正超粗黑繁体");
	        EN_TO_CN_KNOWN_FONT.put("FZCuHei-B03T", "方正粗黑繁体");
	        EN_TO_CN_KNOWN_FONT.put("FZCuYuan-M03T", "方正粗圆繁体");
	        EN_TO_CN_KNOWN_FONT.put("FZDaBiaoSong-B06T", "方正大标宋繁体");
	        EN_TO_CN_KNOWN_FONT.put("FZFangSong-Z02T", "方正仿宋繁体");
	        EN_TO_CN_KNOWN_FONT.put("FZHei-B01T", "方正黑体繁体");
	        EN_TO_CN_KNOWN_FONT.put("FZHuPo-M04T", "方正琥珀繁体");
	        EN_TO_CN_KNOWN_FONT.put("FZKai-Z03T", "方正楷体繁体");
	        EN_TO_CN_KNOWN_FONT.put("FZLiBian-S02T", "方正隶变繁体");
	        EN_TO_CN_KNOWN_FONT.put("FZPingHei-B04T", "方正平黑繁体");
	        EN_TO_CN_KNOWN_FONT.put("FZShuSong-Z01T", "方正书宋繁体");
	        EN_TO_CN_KNOWN_FONT.put("FZShuTi-S05T", "方正舒体繁体");
	        EN_TO_CN_KNOWN_FONT.put("FZWeiBei-S03T", "方正魏碑繁体");
	        EN_TO_CN_KNOWN_FONT.put("FZXiHei", "方正细黑一繁体");
	        EN_TO_CN_KNOWN_FONT.put("FZXiYuan-M01T", "方正细圆繁体");
	        EN_TO_CN_KNOWN_FONT.put("FZXiaoBiaoSong-B05T", "方正小标宋繁体");
	        EN_TO_CN_KNOWN_FONT.put("FZNew", "方正新书宋繁体");
	        EN_TO_CN_KNOWN_FONT.put("FZNew", "方正新秀丽繁体");
	        EN_TO_CN_KNOWN_FONT.put("FZXingKai-S04T", "方正行楷繁体");
	        EN_TO_CN_KNOWN_FONT.put("FZYouXian-Z09T", "方正幼线繁体");
	        EN_TO_CN_KNOWN_FONT.put("FZZhongKai-B08T", "方正中楷繁体");
	        EN_TO_CN_KNOWN_FONT.put("FZZhunYuan-M02T", "方正准圆繁体");
	        EN_TO_CN_KNOWN_FONT.put("FZZongYi-M05T", "方正综艺繁体");
	        EN_TO_CN_KNOWN_FONT.put("FZLiShu", "方正隶二繁体");
	        EN_TO_CN_KNOWN_FONT.put("FZNew", "方正新舒体繁体");
	        EN_TO_CN_KNOWN_FONT.put("FZKangTi-S07T", "方正康体繁体");
	        EN_TO_CN_KNOWN_FONT.put("FZShuiZhu-M08T", "方正水柱繁体");
	        EN_TO_CN_KNOWN_FONT.put("FZYaoTi-M06T", "方正姚体繁体");
	        EN_TO_CN_KNOWN_FONT.put("FZShouJinShu-S10T", "方正瘦金书繁体");
	        EN_TO_CN_KNOWN_FONT.put("FZShaoEr-M11T", "方正少儿繁体");
	        EN_TO_CN_KNOWN_FONT.put("FZZhiYi-M12T", "方正稚艺繁体");
	        EN_TO_CN_KNOWN_FONT.put("FZXiShanHu-M13T", "方正细珊瑚繁体");
	        EN_TO_CN_KNOWN_FONT.put("FZCuSong-B09T", "方正粗宋繁体");
	        EN_TO_CN_KNOWN_FONT.put("FZPingHe-S11T", "方正平和繁体");
	        EN_TO_CN_KNOWN_FONT.put("FZHuaLi-M14T", "方正华隶繁体");
	        EN_TO_CN_KNOWN_FONT.put("FZZhongDengXian-Z07T", "方正中等线繁体");
	        EN_TO_CN_KNOWN_FONT.put("FZXiQian-M15T", "方正细倩繁体");
	        EN_TO_CN_KNOWN_FONT.put("FZZhongQian-M16T", "方正中倩繁体");
	        EN_TO_CN_KNOWN_FONT.put("FZCuQian-M17T", "方正粗倩繁体");
	        EN_TO_CN_KNOWN_FONT.put("FZPangWa-M18T", "方正胖娃繁体");
	        EN_TO_CN_KNOWN_FONT.put("FZSongYi-Z13T", "方正宋一繁体");
	        EN_TO_CN_KNOWN_FONT.put("FZKaTong-M19S", "方正卡通简体");
	        EN_TO_CN_KNOWN_FONT.put("FZKaTong-M19T", "方正卡通繁体");
	        EN_TO_CN_KNOWN_FONT.put("FZYiHei-M20S", "方正艺黑简体");
	        EN_TO_CN_KNOWN_FONT.put("FZYiHei-M20T", "方正艺黑繁体");
	        EN_TO_CN_KNOWN_FONT.put("FZShuiHei-M21S", "方正水黑简体");
	        EN_TO_CN_KNOWN_FONT.put("FZShuiHei-M21T", "方正水黑繁体");
	        EN_TO_CN_KNOWN_FONT.put("FZGuLi-S12S", "方正古隶简体");
	        EN_TO_CN_KNOWN_FONT.put("FZGuLi-S12T", "方正古隶繁体");
	        EN_TO_CN_KNOWN_FONT.put("FZXiaoZhuanTi-S13T", "方正小篆体");
	        EN_TO_CN_KNOWN_FONT.put("FZYouXian-Z09S", "方正幼线简体");
	        EN_TO_CN_KNOWN_FONT.put("FZQiTi-S14S", "方正启体简体");
	        EN_TO_CN_KNOWN_FONT.put("FZQiTi-S14T", "方正启体繁体");
	        EN_TO_CN_KNOWN_FONT.put("FZYingBiKaiShu-S15S", "方正硬笔楷书简体");
	        EN_TO_CN_KNOWN_FONT.put("FZYingBiKaiShu-S15T", "方正硬笔楷书繁体");
	        EN_TO_CN_KNOWN_FONT.put("FZZhanBiHei-M22S", "方正毡笔黑简体");
	        EN_TO_CN_KNOWN_FONT.put("FZZhanBiHei-M22T", "方正毡笔黑繁体");
	        EN_TO_CN_KNOWN_FONT.put("FZYingBiXingShu-S16S", "方正硬笔行书简体");
	        EN_TO_CN_KNOWN_FONT.put("FZYingBiXingShu-S16T", "方正硬笔行书繁体");
	        EN_TO_CN_KNOWN_FONT.put("FZJianZhi-M23S", "方正剪纸简体");
	        EN_TO_CN_KNOWN_FONT.put("FZJianZhi-M23T", "方正剪纸繁体");
	        EN_TO_CN_KNOWN_FONT.put("FZPangTouYu-M24S", "方正胖头鱼简体");
	        EN_TO_CN_KNOWN_FONT.put("FZTieJinLiShu-Z14S", "方正铁筋隶书简体");
	        EN_TO_CN_KNOWN_FONT.put("FZTieJinLiShu-Z14T", "方正铁筋隶书繁体");
	        EN_TO_CN_KNOWN_FONT.put("FZBeiWeiKaiShu-Z15S", "方正北魏楷书简体");
	        EN_TO_CN_KNOWN_FONT.put("FZBeiWeiKaiShu-Z15T", "方正北魏楷书繁体");
	        EN_TO_CN_KNOWN_FONT.put("FZXiangLi-S17S", "方正祥隶简体");
	        EN_TO_CN_KNOWN_FONT.put("FZXiangLi-S17T", "方正祥隶繁体");
	        EN_TO_CN_KNOWN_FONT.put("FZCuHuoYi-M25S", "方正粗活意简体");
	        EN_TO_CN_KNOWN_FONT.put("FZCuHuoYi-M25T", "方正粗活意繁体");
	        EN_TO_CN_KNOWN_FONT.put("FZLiuXingTi-M26S", "方正流行体简体");
	        EN_TO_CN_KNOWN_FONT.put("FZLiuXingTi-M26T", "方正流行体繁体");
	        EN_TO_CN_KNOWN_FONT.put("FZSongHei-B07T", "方正宋黑繁体");
	        EN_TO_CN_KNOWN_FONT.put("FZDaHei-B02T", "方正大黑繁体");
	        EN_TO_CN_KNOWN_FONT.put("FZLiShu-S01T", "方正隶书繁体");
	        EN_TO_CN_KNOWN_FONT.put("PensinkaiEG-Bold-GB", "文鼎粗钢笔行楷");
	        EN_TO_CN_KNOWN_FONT.put("PensinkaiEG-Medium-GB", "文鼎中钢笔行楷");
	        EN_TO_CN_KNOWN_FONT.put("PensinkaiEG-Light-GB", "文鼎细钢笔行楷");
	        EN_TO_CN_KNOWN_FONT.put("Pop3EG-Extra-GB", "文鼎中特广告体");
	        EN_TO_CN_KNOWN_FONT.put("SheideEG-Medium-GB", "文鼎谁的字体");
	        EN_TO_CN_KNOWN_FONT.put("YankaigungEG-Ultra-GB", "文鼎习字体");
	        EN_TO_CN_KNOWN_FONT.put("ShiangchangEG-Bold-GB", "文鼎香肠体");
	        EN_TO_CN_KNOWN_FONT.put("StoneEG-Extra-GB", "文鼎石头体");
	        EN_TO_CN_KNOWN_FONT.put("SingkaibeiEG-Bold-GB", "文鼎行楷碑体");
	        EN_TO_CN_KNOWN_FONT.put("ShiansaEG-Medium-GB", "文鼎潇洒体");
	        EN_TO_CN_KNOWN_FONT.put("HuabanEG-Ultra-GB", "文鼎花瓣体");
	        EN_TO_CN_KNOWN_FONT.put("PiliEG-Ultra-GB", "文鼎霹雳体");
	        EN_TO_CN_KNOWN_FONT.put("NiuniuEG-Bold-GB", "文鼎妞妞体");
	        EN_TO_CN_KNOWN_FONT.put("JingjiEG-Medium-GB", "文鼎荆棘体");
	        EN_TO_CN_KNOWN_FONT.put("HutzEG-Extra-GB", "文鼎胡子体");
	        EN_TO_CN_KNOWN_FONT.put("JutzEG-Medium-GB", "文鼎竹子体");
	        EN_TO_CN_KNOWN_FONT.put("JiangouEG-Bold-GB", "文鼎贱狗体");
	        EN_TO_CN_KNOWN_FONT.put("TanhuangEG-Bold-GB", "文鼎弹簧体");
	        EN_TO_CN_KNOWN_FONT.put("ChrluenEG-Medium-GB", "文鼎齿轮体");
	        EN_TO_CN_KNOWN_FONT.put("YuanliEG-Bold-GB", "文鼎圆立体");
	        EN_TO_CN_KNOWN_FONT.put("YanshueiEG-Extra-GB", "文鼎淹水体");
	        EN_TO_CN_KNOWN_FONT.put("DiaukeEG-Bold-GB", "文鼎雕刻体");
	        EN_TO_CN_KNOWN_FONT.put("HuochaiEG-Bold-GB", "文鼎火柴体");
	        EN_TO_CN_KNOWN_FONT.put("ShueiguanEG-Bold-GB", "文鼎水管体");
	        EN_TO_CN_KNOWN_FONT.put("Pop4EG-Bold-GB", "文鼎ＰＯＰ－４");
	        EN_TO_CN_KNOWN_FONT.put("JingjiEG-Medium-T-GB", "文鼎荆棘体繁");
	        EN_TO_CN_KNOWN_FONT.put("JiangouEG-Bold-T-GB", "文鼎贱狗体繁");
	        EN_TO_CN_KNOWN_FONT.put("ChrluenEG-Medium-T-GB", "文鼎齿轮体繁");
	        EN_TO_CN_KNOWN_FONT.put("DiaukeEG-Bold-T-GB", "文鼎雕刻体繁");
	        EN_TO_CN_KNOWN_FONT.put("SheideEG-Medium-T-GB", "文鼎谁的字体繁");


	        GraphicsEnvironment e = GraphicsEnvironment.getLocalGraphicsEnvironment();
	        String[] fontNames = e.getAvailableFontFamilyNames();
	        for (String name : fontNames) {
	            SUPPORT_FONT.add(name);
	            SUPPORT_FONT.add(EN_TO_CN_KNOWN_FONT.get(name));
	            SUPPORT_FONT.add(EN_TO_CN_KNOWN_FONT.inverse().get(name));
	        }
	        /*for (String aFontName : SUPPORT_FONT) {
	            //System.out.println(aFontName + "==========spportedFont====");
	        }*/
	    }

	    public static boolean isSupport(String name) {
	        return SUPPORT_FONT.contains(StringUtils.trim(name));
	    }
	    
	    //.xlsx转化成.xls文件
	    public static void xlsx2xls_progress(String inpFn, String outFn) throws InvalidFormatException,IOException {
	        InputStream in = new FileInputStream(inpFn);
	        try {
	            XSSFWorkbook wbIn = new XSSFWorkbook(in);
	            File outF = new File(outFn);
	            if (outF.exists()) {
	                outF.delete();
	            }

	            Workbook wbOut = new HSSFWorkbook();
	            int sheetCnt = wbIn.getNumberOfSheets();
	            System.out.println(sheetCnt);
	            for (int i = 0; i < sheetCnt; i++) {
	                Sheet sIn = wbIn.getSheetAt(i);
	                Sheet sOut = wbOut.createSheet(sIn.getSheetName());
	                Iterator<Row> rowIt = sIn.rowIterator();
	                while (rowIt.hasNext()) {
	                    Row rowIn = rowIt.next();
	                    Row rowOut = sOut.createRow(rowIn.getRowNum());

	                    Iterator<Cell> cellIt = rowIn.cellIterator();
	                    while (cellIt.hasNext()) {
	                        Cell cellIn = cellIt.next();
	                        Cell cellOut = rowOut.createCell(cellIn.getColumnIndex(), cellIn.getCellType());

	                        switch (cellIn.getCellType()) {
	                        case Cell.CELL_TYPE_BLANK: break;

	                        case Cell.CELL_TYPE_BOOLEAN:
	                            cellOut.setCellValue(cellIn.getBooleanCellValue());
	                            break;

	                        case Cell.CELL_TYPE_ERROR:
	                            cellOut.setCellValue(cellIn.getErrorCellValue());
	                            break;

	                        case Cell.CELL_TYPE_FORMULA:
	                            cellOut.setCellFormula(cellIn.getCellFormula());
	                            break;

	                        case Cell.CELL_TYPE_NUMERIC:
	                            cellOut.setCellValue(cellIn.getNumericCellValue());
	                            break;

	                        case Cell.CELL_TYPE_STRING:
	                            cellOut.setCellValue(cellIn.getStringCellValue());
	                            break;
	                        }

	                        {
	                            CellStyle styleIn = cellIn.getCellStyle();
	                            CellStyle styleOut = cellOut.getCellStyle();
	                            styleOut.setDataFormat(styleIn.getDataFormat());
	                        }
	                          //单元格注释
	                          XSSFComment xc = (XSSFComment) cellIn.getCellComment();
	                          if(xc != null){
	                        	  //创建HSSFPatriarch对象,HSSFPatriarch是所有注释的容器.  
	                              HSSFPatriarch patr = (HSSFPatriarch) sOut.createDrawingPatriarch();  
	                        	  HSSFComment hc = patr.createComment(new HSSFClientAnchor(0, 0, 0, 0, (short)4, 2, (short) 6, 5));  
	                              hc.setAuthor(xc.getAuthor());
	                              hc.setColumn(xc.getColumn());
	                              hc.setRow(xc.getRow());
	                              //注释内容
	                              hc.setString(new HSSFRichTextString(xc.getString().getString()));
	                              hc.setVisible(xc.isVisible());
	                              hc.setColumn(xc.getColumn());
	                              cellOut.setCellComment(hc);
	                          }
	                        }
	                }
	            }
	            OutputStream out = new BufferedOutputStream(new FileOutputStream(outF));
	            try {
	                wbOut.write(out);
	            } finally {
	                out.close();
	            }
	        } finally {
	            in.close();
	        }
	    }
}