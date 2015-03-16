package com.lishunan.gpm;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.filefilter.SuffixFileFilter;

import javax.json.Json;
import javax.json.JsonObjectBuilder;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

/**
 * Created by Administrator on 2015/3/16.
 */
public class KtbgUploadServlet extends HttpServlet {

    @Override
    public void doPost (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=utf-8");
        PrintWriter out = response.getWriter();
        JsonObjectBuilder builder = Json.createObjectBuilder();
        if (!JudgePeopleType.judge(request, response).equals("student")){
            builder.add("status", false)
                    .add("message", "权限不足");
            out.print(builder.build());
            return;
        }
        String saccount = request.getSession().getAttribute("username").toString();
        String uploadPath = getServletContext().getRealPath("/") + "开题报告" + "\\" + saccount;
        File folder = new File (uploadPath);
        if (folder.exists()){
            if (folder.isDirectory()){
                File files[] = folder.listFiles();
                for (File f : files)
                    f.delete();
            }
        }
        folder.mkdirs();
        if (ServletFileUpload.isMultipartContent(request)){
            DiskFileItemFactory factory = new DiskFileItemFactory();
            factory.setSizeThreshold(20*1024);
            factory.setRepository(factory.getRepository());
            ServletFileUpload upload = new ServletFileUpload(factory);
            Connection conn = null;
            try {
                conn = DB.getConn();
                List<FileItem> files = upload.parseRequest(request);
                String[] suffixs = new String[] {".exe", ".bat", ".com", ".js"};
                SuffixFileFilter filter = new SuffixFileFilter(suffixs);
                for (FileItem fileItem: files){
                    if (!fileItem.isFormField()){
                        String filePath = fileItem.getName();
                        String fileName = "";
                        int startIndex = filePath.lastIndexOf("\\");
                        if (startIndex != -1)
                            fileName = filePath.substring(startIndex+1);
                        else
                            fileName = filePath;
                        if ( (fileName == null) || (fileName.equals("")) && (fileItem.getSize() == 0)){
                            builder.add("status", false)
                                    .add("message", "文件名不能为空，文件大小也不能为零！");
                            break;
                        }

                        String sql = "update ktbg set FilePath = ? where saccount = ?";

                        PreparedStatement pstmt = conn.prepareStatement(sql);
                        pstmt.setString(1, uploadPath + "\\" + saccount + "_" +fileName);
                        pstmt.setString(2, saccount);
                        int rs = pstmt.executeUpdate();
                        if (rs <= 0){
                            builder.add("status", false)
                                    .add("message", "database update fail");
                            break;
                        }

                        File file = new File (uploadPath, saccount + "_" + fileName);
                        boolean res = filter.accept(file);
                        if (res){
                            builder.add("status", false)
                                    .add("message", "禁止上传 *.exe、*.bat、*.com、*.js文件！");
                            break;
                        }
                        else {
                            fileItem.write(file);
                            builder.add ("status", true)
                                    .add("message", "success");
                        }
                    }
                }
            } catch (ClassNotFoundException e) {
                builder.add("status", false)
                        .add("message", "未知错误");
                e.printStackTrace();
            } catch (SQLException e) {
                builder.add("status", false)
                        .add("message", "未知错误");
                e.printStackTrace();
            } catch (FileUploadException e) {
                builder.add("status", false)
                        .add("message", "未知错误");
                e.printStackTrace();
            } catch (Exception e) {
                builder.add("status", false)
                        .add("message", "未知错误");
                e.printStackTrace();
            } finally {
                try {
                    conn.close();
                } catch (SQLException e) {
                    builder.add("status", false)
                            .add("message", "未知错误");
                    e.printStackTrace();
                }
                out.print(builder.build());
            }
        }
    }

    public void init (ServletConfig config) throws ServletException {
        super.init(config);
    }

    @Override
    public void doGet (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost (request, response);
    }
}
