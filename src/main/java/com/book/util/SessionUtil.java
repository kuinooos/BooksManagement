package com.book.util;

import com.book.domain.ReaderCard;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;

/**
 * Session管理工具类
 * 用于统一处理用户Session验证和管理
 */
public class SessionUtil {
    
    /**
     * 检查读者Session是否有效
     * @param request HTTP请求对象
     * @return 返回ReaderCard对象，如果Session无效则返回null
     */
    public static ReaderCard checkReaderSession(HttpServletRequest request) {
        ReaderCard readerCard = (ReaderCard) request.getSession().getAttribute("readercard");
        return readerCard;
    }
    
    /**
     * 检查读者Session是否有效，如果无效则设置错误信息
     * @param request HTTP请求对象
     * @param redirectAttributes 重定向属性
     * @return 返回ReaderCard对象，如果Session无效则返回null
     */
    public static ReaderCard checkReaderSessionWithError(HttpServletRequest request, RedirectAttributes redirectAttributes) {
        ReaderCard readerCard = (ReaderCard) request.getSession().getAttribute("readercard");
        if (readerCard == null && redirectAttributes != null) {
            redirectAttributes.addFlashAttribute("error", "登录状态已失效，请重新登录");
        }
        return readerCard;
    }
    
    /**
     * 验证读者Session并检查ReaderCard的有效性
     * @param request HTTP请求对象
     * @return 如果Session和ReaderCard都有效返回true，否则返回false
     */
    public static boolean isValidReaderSession(HttpServletRequest request) {
        ReaderCard readerCard = checkReaderSession(request);
        return readerCard != null && readerCard.getReaderId() > 0;
    }
    
    /**
     * 清除用户Session
     * @param request HTTP请求对象
     */
    public static void clearSession(HttpServletRequest request) {
        request.getSession().removeAttribute("readercard");
        request.getSession().removeAttribute("admin");
    }
    
    /**
     * 更新读者Session信息
     * @param request HTTP请求对象
     * @param readerCard 新的读者卡信息
     */
    public static void updateReaderSession(HttpServletRequest request, ReaderCard readerCard) {
        if (readerCard != null) {
            request.getSession().setAttribute("readercard", readerCard);
        }
    }
}
