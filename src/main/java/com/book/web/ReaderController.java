package com.book.web;

import com.book.domain.ReaderCard;
import com.book.domain.ReaderInfo;
import com.book.service.LoginService;
import com.book.service.ReaderCardService;
import com.book.service.ReaderInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

@Controller
public class ReaderController {

    private ReaderInfoService readerInfoService;
    @Autowired
    public void setReaderInfoService(ReaderInfoService readerInfoService) {
        this.readerInfoService = readerInfoService;
    }   private LoginService loginService;


    @Autowired
    public void setLoginService(LoginService loginService) {
        this.loginService = loginService;
    }
    private ReaderCardService readerCardService;

    @Autowired
    public void setReaderCardService(ReaderCardService readerCardService) {
        this.readerCardService = readerCardService;
    }

    @RequestMapping("allreaders.html")
    public ModelAndView allBooks(){
        ArrayList<ReaderInfo> readers=readerInfoService.readerInfos();
        ModelAndView modelAndView=new ModelAndView("admin_readers");
        modelAndView.addObject("readers",readers);
        return modelAndView;
    }

    @RequestMapping("reader_delete.html")
    public String readerDelete(HttpServletRequest request,RedirectAttributes redirectAttributes){
        int readerId= Integer.parseInt(request.getParameter("readerId"));
        boolean success=readerInfoService.deleteReaderInfo(readerId);

        if(success){
            redirectAttributes.addFlashAttribute("succ", "删除成功！");
            return "redirect:/allreaders.html";
        }else {
            redirectAttributes.addFlashAttribute("error", "删除失败！");
            return "redirect:/allreaders.html";
        }

    }    @RequestMapping("/reader_info.html")
    public ModelAndView toReaderInfo(HttpServletRequest request) {
        // 检查Session中的读者信息
        ReaderCard readerCard = (ReaderCard) request.getSession().getAttribute("readercard");
        
        // 如果Session中没有读者信息，重定向到登录页面
        if (readerCard == null) {
            return new ModelAndView("redirect:/login.html");
        }
        
        try {
            ReaderInfo readerInfo = readerInfoService.getReaderInfo(readerCard.getReaderId());
            ModelAndView modelAndView = new ModelAndView("reader_info");
            modelAndView.addObject("readerinfo", readerInfo);
            return modelAndView;
        } catch (Exception e) {
            // 如果获取读者信息失败，重定向到登录页面
            return new ModelAndView("redirect:/login.html");
        }
    }
    @RequestMapping("reader_edit.html")
    public ModelAndView readerInfoEdit(HttpServletRequest request){
        int readerId= Integer.parseInt(request.getParameter("readerId"));
        ReaderInfo readerInfo=readerInfoService.getReaderInfo(readerId);
        ModelAndView modelAndView=new ModelAndView("admin_reader_edit");
        modelAndView.addObject("readerInfo",readerInfo);        return modelAndView;
    }
    
    @RequestMapping(value = "reader_edit_do.html", method = RequestMethod.POST)
    public String readerInfoEditDo(HttpServletRequest request,String name,String sex,String birth,String address,String telcode,RedirectAttributes redirectAttributes){
        int readerId= Integer.parseInt(request.getParameter("id"));
        ReaderCard readerCard = loginService.findReaderCardByUserId(readerId);
        
        // 检查读者卡是否存在
        if (readerCard == null) {
            redirectAttributes.addFlashAttribute("error", "读者不存在！");
            return "redirect:/allreaders.html";
        }
        
        String oldName=readerCard.getName();
        if(!oldName.equals(name)){
            boolean succo=readerCardService.updateName(readerId,name);
            SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
            Date nbirth=new Date();
            try{
                java.util.Date date=sdf.parse(birth);
                nbirth=date;
            }catch (ParseException e){
                e.printStackTrace();
            }
            ReaderInfo readerInfo=new ReaderInfo();
            readerInfo.setAddress(address);
            readerInfo.setBirth(nbirth);
            readerInfo.setName(name);
            readerInfo.setReaderId(readerId);
            readerInfo.setTelcode(telcode);
            readerInfo.setSex(sex);
            boolean succ=readerInfoService.editReaderInfo(readerInfo);
            if(succo&&succ){
                redirectAttributes.addFlashAttribute("succ", "读者信息修改成功！");
                return "redirect:/allreaders.html";
            }else {
                redirectAttributes.addFlashAttribute("error", "读者信息修改失败！");
                return "redirect:/allreaders.html";
            }
        }
        else {
            System.out.println("部分修改");
            SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
            Date nbirth=new Date();
            try{
                java.util.Date date=sdf.parse(birth);
                nbirth=date;
            }catch (ParseException e){
                e.printStackTrace();
            }
            ReaderInfo readerInfo=new ReaderInfo();
            readerInfo.setAddress(address);
            readerInfo.setBirth(nbirth);
            readerInfo.setName(name);
            readerInfo.setReaderId(readerId);
            readerInfo.setTelcode(telcode);
            readerInfo.setSex(sex);

            boolean succ=readerInfoService.editReaderInfo(readerInfo);
            if(succ){
                redirectAttributes.addFlashAttribute("succ", "读者信息修改成功！");
                return "redirect:/allreaders.html";
            }else {
                redirectAttributes.addFlashAttribute("error", "读者信息修改失败！");
                return "redirect:/allreaders.html";
            }
        }

    }

    @RequestMapping("reader_add.html")
    public ModelAndView readerInfoAdd(){
        ModelAndView modelAndView=new ModelAndView("admin_reader_add");
        return modelAndView;

    }
    //用户功能--进入修改密码页面
    @RequestMapping("reader_repasswd.html")
    public ModelAndView readerRePasswd(){
        ModelAndView modelAndView=new ModelAndView("reader_repasswd");
        return modelAndView;    }
    //用户功能--修改密码执行
    @RequestMapping(value = "reader_repasswd_do.html", method = RequestMethod.POST)
    public String readerRePasswdDo(HttpServletRequest request,String oldPasswd,String newPasswd,String reNewPasswd,RedirectAttributes redirectAttributes){
        // 检查Session中的读者信息
        ReaderCard readerCard = (ReaderCard) request.getSession().getAttribute("readercard");
        
        // 如果Session中没有读者信息，重定向到登录页面
        if (readerCard == null) {
            redirectAttributes.addFlashAttribute("error", "登录状态已失效，请重新登录");
            return "redirect:/login.html";
        }
        
        try {
            int readerId = readerCard.getReaderId();
            String passwd = readerCard.getPasswd();

            if (newPasswd.equals(reNewPasswd)){                if(passwd.equals(oldPasswd)){
                    boolean succ = readerCardService.updatePasswd(readerId,newPasswd);
                    if (succ){                        ReaderCard readerCardNew = loginService.findReaderCardByUserId(readerId);
                        if (readerCardNew != null) {
                            request.getSession().setAttribute("readercard", readerCardNew);
                        }
                        redirectAttributes.addFlashAttribute("succ", "密码修改成功！");
                        return "redirect:/reader_repasswd.html";
                    } else {
                        redirectAttributes.addFlashAttribute("error", "密码修改失败！");
                        return "redirect:/reader_repasswd.html";
                    }
                } else {
                    redirectAttributes.addFlashAttribute("error", "修改失败,原密码错误");
                    return "redirect:/reader_repasswd.html";
                }
            } else {
                redirectAttributes.addFlashAttribute("error", "修改失败,两次输入的新密码不相同");
                return "redirect:/reader_repasswd.html";
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "系统错误，请重新登录");
            return "redirect:/login.html";
        }
    }    // 管理员功能--读者信息添加    
    @RequestMapping(value = "reader_add_do.html", method = RequestMethod.POST)
    public String readerInfoAddDo(String name, String sex, String birth, String address, String telcode, 
                                  Integer readerId, RedirectAttributes redirectAttributes, Model model){
        try {
            // 日志记录接收到的参数
            System.out.println("接收到的读者信息：");
            System.out.println("读者证号: " + readerId);
            System.out.println("姓名: " + name);
            System.out.println("性别: " + sex);
            System.out.println("出生日期: " + birth);
            System.out.println("地址: " + address);
            System.out.println("电话: " + telcode);
            
            // 验证必填字段 - 返回到添加页面而不是重定向
            if (readerId == null || readerId <= 0) {
                model.addAttribute("error", "读者证号必须是正整数！");
                model.addAttribute("name", name);
                model.addAttribute("sex", sex);
                model.addAttribute("birth", birth);
                model.addAttribute("address", address);
                model.addAttribute("telcode", telcode);
                return "admin_reader_add";
            }
            if (name == null || name.trim().isEmpty()) {
                model.addAttribute("error", "姓名不能为空！");
                model.addAttribute("readerId", readerId);
                model.addAttribute("sex", sex);
                model.addAttribute("birth", birth);
                model.addAttribute("address", address);
                model.addAttribute("telcode", telcode);
                return "admin_reader_add";
            }
            if (sex == null || sex.trim().isEmpty()) {
                model.addAttribute("error", "性别不能为空！");
                model.addAttribute("readerId", readerId);
                model.addAttribute("name", name);
                model.addAttribute("birth", birth);
                model.addAttribute("address", address);
                model.addAttribute("telcode", telcode);
                return "admin_reader_add";
            }
            if (birth == null || birth.trim().isEmpty()) {
                model.addAttribute("error", "生日不能为空！");
                model.addAttribute("readerId", readerId);
                model.addAttribute("name", name);
                model.addAttribute("sex", sex);
                model.addAttribute("address", address);
                model.addAttribute("telcode", telcode);
                return "admin_reader_add";
            }
            if (address == null || address.trim().isEmpty()) {
                model.addAttribute("error", "地址不能为空！");
                model.addAttribute("readerId", readerId);
                model.addAttribute("name", name);
                model.addAttribute("sex", sex);
                model.addAttribute("birth", birth);
                model.addAttribute("telcode", telcode);
                return "admin_reader_add";
            }
            if (telcode == null || telcode.trim().isEmpty()) {
                model.addAttribute("error", "电话号码不能为空！");
                model.addAttribute("readerId", readerId);
                model.addAttribute("name", name);
                model.addAttribute("sex", sex);
                model.addAttribute("birth", birth);
                model.addAttribute("address", address);
                return "admin_reader_add";
            }
            
            // 验证数据格式
            if (!sex.equals("男") && !sex.equals("女")) {
                model.addAttribute("error", "性别只能是'男'或'女'！");
                model.addAttribute("readerId", readerId);
                model.addAttribute("name", name);
                model.addAttribute("birth", birth);
                model.addAttribute("address", address);
                model.addAttribute("telcode", telcode);
                return "admin_reader_add";
            }
            
            // 验证电话号码格式（简单验证）
            if (!telcode.matches("^1[3-9]\\d{9}$")) {
                model.addAttribute("error", "请输入有效的手机号码！");
                model.addAttribute("readerId", readerId);
                model.addAttribute("name", name);
                model.addAttribute("sex", sex);
                model.addAttribute("birth", birth);
                model.addAttribute("address", address);
                return "admin_reader_add";
            }
            
            SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
            Date nbirth=new Date();
            try{
                java.util.Date date=sdf.parse(birth);
                nbirth=date;
            }catch (ParseException e){
                e.printStackTrace();
                model.addAttribute("error", "生日格式错误，请使用 yyyy-MM-dd 格式！");
                model.addAttribute("readerId", readerId);
                model.addAttribute("name", name);
                model.addAttribute("sex", sex);
                model.addAttribute("address", address);
                model.addAttribute("telcode", telcode);
                return "admin_reader_add";
            }

            ReaderInfo readerInfo=new ReaderInfo();
            readerInfo.setAddress(address);
            readerInfo.setBirth(nbirth);
            readerInfo.setName(name);
            readerInfo.setReaderId(readerId);
            readerInfo.setTelcode(telcode);
            readerInfo.setSex(sex);
            
            boolean succ=readerInfoService.addReaderInfo(readerInfo);
            boolean succc=readerCardService.addReaderCard(readerInfo);
            
            System.out.println("读者信息添加结果: " + succ);
            System.out.println("读者卡添加结果: " + succc);
            
            if (succ&&succc){
                redirectAttributes.addFlashAttribute("succ", "添加读者信息成功！");
                return "redirect:/allreaders.html";
            }else {
                model.addAttribute("error", "添加读者失败！可能是读者证号已存在或数据库连接问题。");
                model.addAttribute("readerId", readerId);
                model.addAttribute("name", name);
                model.addAttribute("sex", sex);
                model.addAttribute("birth", birth);
                model.addAttribute("address", address);
                model.addAttribute("telcode", telcode);
                return "admin_reader_add";
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("读者添加异常: " + e.getMessage());
            model.addAttribute("error", "添加读者失败: " + e.getMessage());
            model.addAttribute("readerId", readerId);
            model.addAttribute("name", name);
            model.addAttribute("sex", sex);
            model.addAttribute("birth", birth);
            model.addAttribute("address", address);
            model.addAttribute("telcode", telcode);
            return "admin_reader_add";
        }
    }
//读者功能--读者信息修改
    @RequestMapping("reader_info_edit.html")
    public ModelAndView readerInfoEditReader(HttpServletRequest request){
        // 检查Session中的读者信息
        ReaderCard readerCard = (ReaderCard) request.getSession().getAttribute("readercard");
        
        // 如果Session中没有读者信息，重定向到登录页面
        if (readerCard == null) {
            return new ModelAndView("redirect:/login.html");
        }
        
        try {
            ReaderInfo readerInfo = readerInfoService.getReaderInfo(readerCard.getReaderId());
            ModelAndView modelAndView = new ModelAndView("reader_info_edit");
            modelAndView.addObject("readerinfo", readerInfo);
            return modelAndView;        } catch (Exception e) {
            // 如果获取读者信息失败，重定向到登录页面
            return new ModelAndView("redirect:/login.html");
        }
    }    // 读者功能--读者信息修改执行
    @RequestMapping(value = "reader_edit_do_r.html", method = RequestMethod.POST)
    public String readerInfoEditDoReader(HttpServletRequest request, String name, String sex, String birth, String address, String telcode, RedirectAttributes redirectAttributes) {
        // 检查Session中的读者信息
        ReaderCard readerCard = (ReaderCard) request.getSession().getAttribute("readercard");
        
        // 如果Session中没有读者信息，重定向到登录页面
        if (readerCard == null) {
            redirectAttributes.addFlashAttribute("error", "登录状态已失效，请重新登录");
            return "redirect:/login.html";
        }
        
        try {
            // 解析生日
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date nbirth = new Date();
            try {
                java.util.Date date = sdf.parse(birth);
                nbirth = date;
            } catch (ParseException e) {
                e.printStackTrace();
                redirectAttributes.addFlashAttribute("error", "日期格式错误！");
                return "redirect:/reader_info.html";
            }

            // 检查是否需要更新姓名
            boolean nameChanged = !readerCard.getName().equals(name);
            boolean succo = true;
            
            if (nameChanged) {
                succo = readerCardService.updateName(readerCard.getReaderId(), name);
            }

            // 更新读者信息
            ReaderInfo readerInfo = new ReaderInfo();
            readerInfo.setAddress(address);
            readerInfo.setBirth(nbirth);
            readerInfo.setName(name);
            readerInfo.setReaderId(readerCard.getReaderId());
            readerInfo.setTelcode(telcode);
            readerInfo.setSex(sex);

            boolean succ = readerInfoService.editReaderInfo(readerInfo);
              if (succ && succo) {
                // 更新Session中的读者信息
                ReaderCard readerCardNew = loginService.findReaderCardByUserId(readerCard.getReaderId());
                if (readerCardNew != null) {
                    request.getSession().setAttribute("readercard", readerCardNew);
                }
                redirectAttributes.addFlashAttribute("succ", "信息修改成功！");
                return "redirect:/reader_info.html";
            } else {
                redirectAttributes.addFlashAttribute("error", "信息修改失败！");
                return "redirect:/reader_info.html";
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "系统错误，请重新登录");
            return "redirect:/login.html";
        }
    }
}
