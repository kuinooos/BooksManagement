package com.book.web;

import com.book.domain.Admin;
import com.book.domain.ReaderCard;
import com.book.domain.ReaderInfo;
import com.book.service.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;

//标注为一个Spring mvc的Controller
@Controller
public class LoginController {

    private LoginService loginService;


    @Autowired
    public void setLoginService(LoginService loginService) {
        this.loginService = loginService;
    }    //负责处理login.html请求
    @RequestMapping(value = {"/","/login.html"})//将 HTTP 请求映射到特定的控制器方法
    public String toLogin(HttpServletRequest request){
        request.getSession().invalidate();
        return "index";// // 返回视图名称 "index"
    }
    @RequestMapping("/logout.html")
    public String logout(HttpServletRequest request) {
        request.getSession().invalidate();
        return "redirect:/login.html";
    }


    //负责处理loginCheck.html请求
    //请求参数会根据参数名称默认契约自动绑定到相应方法的入参中
    @RequestMapping(value = "/loginCheck", method = RequestMethod.POST)
    public @ResponseBody Object loginCheck(HttpServletRequest request){
        int id=Integer.parseInt(request.getParameter("id"));
        String passwd = request.getParameter("passwd");
                boolean isReader = loginService.hasMatchReader(id, passwd);
                boolean isAdmin = loginService.hasMatchAdmin(id, passwd);
        HashMap<String, String> res = new HashMap<String, String>();
        
                if (isAdmin==false&&isReader==false) {
                    res.put("stateCode", "0");
                    res.put("msg","账号或密码错误！");
                } else if(isAdmin){
                    Admin admin=new Admin();
                    admin.setAdminId(id);
                    admin.setPassword(passwd);
                    request.getSession().setAttribute("admin",admin);
                    res.put("stateCode", "1");
                    res.put("msg","管理员登陆成功！");
                }else {
                    ReaderCard readerCard = loginService.findReaderCardByUserId(id);
                    request.getSession().setAttribute("readercard", readerCard);
                    res.put("stateCode", "2");
                    res.put("msg","读者登陆成功！");
                }
        return res;
    };

    // API版本的登录检查 - 用于Ajax请求
    @RequestMapping(value = "/api/loginCheck", method = RequestMethod.POST)
    public @ResponseBody Object apiLoginCheck(HttpServletRequest request){
        return loginCheck(request); // 复用现有的登录逻辑
    }

    @RequestMapping("/admin_main.html")
    public ModelAndView toAdminMain(HttpServletRequest request, HttpServletResponse response) {
        // 检查管理员是否已登录
        Admin admin = (Admin) request.getSession().getAttribute("admin");
        if (admin == null) {
            // 如果未登录，重定向到登录页面
            return new ModelAndView("redirect:/login.html");
        }
        
        ModelAndView modelAndView = new ModelAndView("admin_main");
        modelAndView.addObject("login", "1"); // 添加登录成功标识
        return modelAndView;
    }


    @RequestMapping("/reader_main.html")
    public ModelAndView toReaderMain(HttpServletResponse response) {

        return new ModelAndView("reader_main");
    }

    @RequestMapping("/admin_repasswd.html")
    public ModelAndView reAdminPasswd(HttpServletRequest request) {
        // 检查Session中的管理员信息
        Admin admin = (Admin) request.getSession().getAttribute("admin");
        
        // 如果Session中没有管理员信息，重定向到登录页面
        if (admin == null) {
            return new ModelAndView("redirect:/login.html");
        }
        
        return new ModelAndView("admin_repasswd");
    }
      @RequestMapping(value = "/admin_repasswd_do", method = RequestMethod.POST)
    public String reAdminPasswdDo(HttpServletRequest request,String oldPasswd,String newPasswd,String reNewPasswd,RedirectAttributes redirectAttributes ) {
        // 检查Session中的管理员信息
        Admin admin=(Admin) request.getSession().getAttribute("admin");
        
        // 如果Session中没有管理员信息，重定向到登录页面
        if (admin == null) {
            redirectAttributes.addFlashAttribute("error", "登录状态已失效，请重新登录");
            return "redirect:/login.html";
        }
        
        try {
            // 验证两次新密码是否一致
            if (!newPasswd.equals(reNewPasswd)) {
                redirectAttributes.addFlashAttribute("error", "两次输入的新密码不一致！");
                return "redirect:/admin_repasswd.html";
            }
            
            // 验证新密码长度
            if (newPasswd.length() < 6) {
                redirectAttributes.addFlashAttribute("error", "新密码长度不能少于6位！");
                return "redirect:/admin_repasswd.html";
            }
            
            int id = admin.getAdminId();
            String passwd = loginService.getAdminPasswd(id);

            if(passwd.equals(oldPasswd)){
                boolean succ = loginService.adminRePasswd(id,newPasswd);
                if (succ){
                    redirectAttributes.addFlashAttribute("succ", "密码修改成功！");
                    return "redirect:/admin_repasswd.html";
                }
                else {
                    redirectAttributes.addFlashAttribute("error", "密码修改失败！");
                    return "redirect:/admin_repasswd.html";
                }
            }else {
                redirectAttributes.addFlashAttribute("error", "旧密码错误！");
                return "redirect:/admin_repasswd.html";
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "系统错误，请重新登录");
            return "redirect:/login.html";
        }
    };

    // 添加测试页面路由
    @RequestMapping("/test-login.html")
    public String toTestLogin() {
        return "redirect:/test-login.html";
    }
    
    @RequestMapping("/simple-test.html")
    public String toSimpleTest() {
        return "redirect:/simple-test.html";
    }

    @RequestMapping("/simple-login-test")
    @ResponseBody
    public Object simpleLoginTest() {
        HashMap<String, String> result = new HashMap<>();
        result.put("status", "success");
        result.put("message", "登录API端点正常工作");
        result.put("timestamp", String.valueOf(System.currentTimeMillis()));
        return result;
    }
    //配置404页面 - 移除通配符，改为更具体的路径
    // @RequestMapping("*")  
    // public String notFind(){
    // return "404";
    // }


}