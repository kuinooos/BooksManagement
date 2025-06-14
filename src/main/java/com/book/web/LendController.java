package com.book.web;

import com.book.domain.Book;
import com.book.domain.ReaderCard;
import com.book.service.BookService;
import com.book.service.LendService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;

@Controller
public class LendController {

    private LendService lendService;
    @Autowired
    public void setLendService(LendService lendService) {
        this.lendService = lendService;
    }
    private BookService bookService;
    @Autowired
    public void setBookService(BookService bookService) {
        this.bookService = bookService;
    }

    @RequestMapping("/lendbook.html")    public ModelAndView bookLend(HttpServletRequest request){
        long bookId=Integer.parseInt(request.getParameter("bookId"));
        Book book=bookService.getBook(bookId);
       ModelAndView modelAndView=new ModelAndView("admin_book_lend");
       modelAndView.addObject("book",book);
       return modelAndView;
    }
    
    @RequestMapping(value = "/lendbookdo.html", method = RequestMethod.POST)
    public String bookLendDo(HttpServletRequest request,RedirectAttributes redirectAttributes,int readerId){
        long bookId=Integer.parseInt(request.getParameter("id"));
        boolean lendsucc=lendService.bookLend(bookId,readerId);
        if (lendsucc){
            redirectAttributes.addFlashAttribute("succ", "图书借阅成功！");
            return "redirect:/allbooks.html";
        }else {
            redirectAttributes.addFlashAttribute("succ", "图书借阅成功！");
            return "redirect:/allbooks.html";
        }


    }

    @RequestMapping("/returnbook.html")
    public String bookReturn(HttpServletRequest request,RedirectAttributes redirectAttributes){
        long bookId=Integer.parseInt(request.getParameter("bookId"));
        boolean retSucc=lendService.bookReturn(bookId);
        if (retSucc){
            redirectAttributes.addFlashAttribute("succ", "图书归还成功！");
            return "redirect:/allbooks.html";
        }
        else {
            redirectAttributes.addFlashAttribute("error", "图书归还失败！");
            return "redirect:/allbooks.html";
        }
    }


    @RequestMapping("/lendlist.html")
    public ModelAndView lendList(){

        ModelAndView modelAndView=new ModelAndView("admin_lend_list");
        modelAndView.addObject("list",lendService.lendList());
        return modelAndView;
    }    @RequestMapping("/mylend.html")
    public ModelAndView myLend(HttpServletRequest request){
        ReaderCard readerCard=(ReaderCard) request.getSession().getAttribute("readercard");
        
        // 检查Session中的读者信息
        if (readerCard == null) {
            return new ModelAndView("redirect:/login.html");
        }
        
        ModelAndView modelAndView=new ModelAndView("reader_lend_list");
        modelAndView.addObject("list",lendService.myLendList(readerCard.getReaderId()));
        return modelAndView;
    }

    // 添加删除借还记录的控制器方法
    @RequestMapping("/deletelend.html")
    public String deleteLendRecord(HttpServletRequest request, RedirectAttributes redirectAttributes){
        try {
            long sernum = Long.parseLong(request.getParameter("sernum"));
            boolean success = lendService.deleteLendRecord(sernum);
            
            if (success) {
                redirectAttributes.addFlashAttribute("succ", "借还记录删除成功！");
            } else {
                redirectAttributes.addFlashAttribute("error", "借还记录删除失败！");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "删除操作出现错误：" + e.getMessage());
        }
        
        return "redirect:/lendlist.html";
    }




}
