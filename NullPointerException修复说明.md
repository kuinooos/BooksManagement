# NullPointerException修复完成报告

## 🐛 问题描述
```
HTTP ERROR 500 
javax.servlet.ServletException: org.springframework.web.util.NestedServletException: 
Request processing failed; nested exception is java.lang.NullPointerException: 
Cannot invoke "com.book.domain.ReaderCard.getReaderId()" because "readerCard" is null
```

## 🔍 问题分析

### 根本原因
1. **Session中的readerCard对象为null**：用户未登录或Session失效时，从Session中获取的readerCard为null
2. **数据库查询返回空对象**：ReaderCardDao.findReaderByReaderId方法在找不到记录时返回空对象而非null
3. **缺乏null值检查**：多个Controller方法直接调用readerCard.getReaderId()而未检查null值

### 影响范围
- `LendController.mylend.html` - 我的借还功能
- `ReaderController`的多个方法 - 读者信息相关功能
- Session管理相关的所有读者功能

## ✅ 修复方案

### 1. 修复LendController
**文件**：`src/main/java/com/book/web/LendController.java`

**修复内容**：
```java
@RequestMapping("/mylend.html")
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
```

**修复说明**：在调用`readerCard.getReaderId()`之前检查readerCard是否为null。

### 2. 修复ReaderCardDao
**文件**：`src/main/java/com/book/dao/ReaderCardDao.java`

**修复内容**：
```java
public ReaderCard findReaderByReaderId(int userId){
    final ReaderCard readerCard=new ReaderCard();
    jdbcTemplate.query(FIND_READER_BY_USERID, new Object[]{userId},
            new RowCallbackHandler() {
                public void processRow(ResultSet resultSet) throws SQLException {
                    readerCard.setReaderId(resultSet.getInt("reader_id"));
                    readerCard.setPasswd(resultSet.getString("passwd"));
                    readerCard.setName(resultSet.getString("name"));
                    readerCard.setCardState(resultSet.getInt("card_state"));
                }
            });
    
    // 如果没有找到记录，返回null而不是空对象
    if (readerCard.getReaderId() == 0) {
        return null;
    }
    
    return readerCard;
}
```

**修复说明**：当数据库中没有找到对应记录时，返回null而不是空的ReaderCard对象。

### 3. 修复ReaderController
**文件**：`src/main/java/com/book/web/ReaderController.java`

**修复内容**：
1. **reader_edit_do.html方法**：增加ReaderCard存在性检查
2. **Session更新方法**：增加null检查后再更新Session

```java
// 在reader_edit_do.html方法中
ReaderCard readerCard = loginService.findReaderCardByUserId(readerId);
if (readerCard == null) {
    redirectAttributes.addFlashAttribute("error", "读者不存在！");
    return "redirect:/allreaders.html";
}

// 在Session更新时
ReaderCard readerCardNew = loginService.findReaderCardByUserId(readerId);
if (readerCardNew != null) {
    request.getSession().setAttribute("readercard", readerCardNew);
}
```

### 4. 创建SessionUtil工具类
**文件**：`src/main/java/com/book/util/SessionUtil.java`

**功能**：
- 统一的Session验证方法
- Session清除和更新方法
- 错误信息统一处理

## 🧪 测试验证

### 测试用例
1. **Session失效测试**
   - 清除浏览器Cookie后访问读者功能页面
   - 应正确重定向到登录页面而不是出现500错误

2. **数据库记录不存在测试**
   - 访问不存在读者ID的编辑页面
   - 应显示友好错误信息而不是崩溃

3. **正常功能测试**
   - 正常登录后访问"我的借还"页面
   - 修改读者信息功能
   - 密码修改功能

### 验证工具
运行 `NullPointerException修复验证.bat` 进行自动化验证。

## 📋 修复清单

- ✅ **LendController.mylend()** - 增加Session null检查
- ✅ **ReaderCardDao.findReaderByReaderId()** - 返回null而非空对象
- ✅ **ReaderController.reader_edit_do()** - 增加读者存在性检查
- ✅ **ReaderController.reader_repasswd_do()** - Session更新null检查
- ✅ **ReaderController.reader_edit_do_r()** - Session更新null检查
- ✅ **SessionUtil工具类** - 统一Session管理
- ✅ **验证脚本** - 自动化测试工具

## 🔧 部署说明

1. **编译项目**：
   ```bash
   mvn clean compile
   ```

2. **启动系统**：
   ```bash
   mvn jetty:run
   ```

3. **验证修复**：
   - 访问 http://localhost:9000
   - 登录读者账户测试各项功能
   - 在新浏览器标签页测试Session失效情况

## 💡 预防措施

1. **代码规范**：
   - 所有Session获取操作都应检查null值
   - 数据库查询结果应合理处理空值情况
   - 使用统一的Session管理工具类

2. **错误处理**：
   - 提供友好的错误信息而不是系统异常
   - 正确的页面重定向机制
   - 日志记录便于问题排查

3. **测试覆盖**：
   - 异常情况的测试用例
   - Session管理相关的测试
   - 边界条件测试

## 🎯 修复效果

修复完成后，系统将：
- ✅ 不再出现readerCard相关的NullPointerException
- ✅ 正确处理Session失效情况
- ✅ 提供友好的用户体验
- ✅ 保持系统稳定性和健壮性

---
*修复完成时间：2025年6月11日*  
*修复版本：图书管理系统 v2.1*
