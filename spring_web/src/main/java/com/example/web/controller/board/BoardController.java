package com.example.web.controller.board;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.example.web.model.BoardDAO;
import com.example.web.model.BoardDTO;
import com.example.web.util.PageUtil;
import com.example.web.model.ReplyDAO;
import com.example.web.util.UploadFileUtils;

@Controller
@RequestMapping("/board/*")
public class BoardController {
	
	String upload_path="c:/upload";
	
	@Autowired
	BoardDAO boardDao;
	
	@Autowired
	ReplyDAO replyDao;
	
	
	@RequestMapping("write.do")
	public String write() {
		return "board/write";
	}
	
	@RequestMapping("insert.do")
	public String insert(@ModelAttribute BoardDTO dto, HttpSession session, Model model) throws Exception{
		String writer=(String)session.getAttribute("user_id");
		dto.setWriter(writer);
		
		String title= dto.getTitle();
		
		if(title.equals("")) {
			
			return "board/write";
			
		}
				
		System.out.println(dto);
		boardDao.insert(dto);
		
		
		//String filename=file.getOriginalFilename();
		System.out.println("idx:"+dto.getIdx());
		MultipartFile[] file=dto.getFile();
		
		
		
			for(MultipartFile part: file) {
			//dto.setFiles(file[i].getOriginalFilename());
				if(!part.isEmpty()) {
						String str =UploadFileUtils.uploadFile(upload_path,part.getOriginalFilename(), part.getBytes());
			
						boardDao.insert_attach(str);
			}
			
			
			}
			
		
	
		return "redirect:/board/list.do";
	}
	
	
	@RequestMapping("list.do")
	public ModelAndView list(@RequestParam(defaultValue="1") int curPage,
			@RequestParam(defaultValue="all") String search_option,
			@RequestParam(defaultValue="") String keyword) {
		int count=boardDao.count(search_option, keyword);
		PageUtil page_info = new PageUtil(count, curPage);
		int start=page_info.getPageBegin();
		int end=page_info.getPageEnd();
				
		List<BoardDTO> list= boardDao.list(start, end, search_option, keyword);
				
		ModelAndView mav= new ModelAndView();
		mav.setViewName("board/list");
		
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("count", count);
		map.put("search_option", search_option);
		map.put("keyword", keyword);
		map.put("page_info", page_info);
		mav.addObject("map",map);		
		return mav;
	}
	@RequestMapping("list1.do")
	public ModelAndView list1(@RequestParam(defaultValue="1") int curPage,
			@RequestParam(defaultValue="all") String search_option,
			@RequestParam(defaultValue="") String keyword) {
		int count=boardDao.count(search_option, keyword);
		PageUtil page_info = new PageUtil(count, curPage);
		int start=page_info.getPageBegin();
		int end=page_info.getPageEnd();
				
		List<BoardDTO> list= boardDao.list(start, end, search_option, keyword);
				
		ModelAndView mav= new ModelAndView();
		mav.setViewName("board/list");
		
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("count", count);
		map.put("serch_option", search_option);
		map.put("keyword", keyword);
		map.put("page_info", page_info);
		mav.addObject("map",map);		
		return mav;
	}
	
	
	@RequestMapping("listM.do")
	public ModelAndView listM(@RequestParam(defaultValue="1") int curPage,
			@RequestParam(defaultValue="all") String search_option,
			@RequestParam(defaultValue="") String keyword) {
		int count=boardDao.count(search_option, keyword);
		PageUtil page_info = new PageUtil(count, curPage);
		int start=page_info.getPageBegin();
		int end=page_info.getPageEnd();
				
		List<BoardDTO> list= boardDao.list(start, end, search_option, keyword);
				
		ModelAndView mav= new ModelAndView();
		mav.setViewName("board/listM");
		
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("count", count);
		map.put("serch_option", search_option);
		map.put("keyword", keyword);
		map.put("page_info", page_info);
		mav.addObject("map",map);		
		return mav;
	}
	
	
	
	@RequestMapping("detail.do")
	public ModelAndView detail(int idx, int cur_page, String search_option, String keyword) {
				
		boardDao.increase_hit(idx);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("board/view");
		mav.addObject("dto", boardDao.detail(idx));
		mav.addObject("count", replyDao.count(idx));
		mav.addObject("cur_page",cur_page);
		mav.addObject("serch_option",search_option);
		mav.addObject("keyword",keyword);
		
		
		List<String> filelists=boardDao.file_detail(idx);	
		String html="";
		
		if(filelists!=null) {			
			for(String list : filelists) {
				
				String filelist= list;
				String original= list.substring(list.indexOf("_")+1);
				
				html+="<a href='/board/download?file_name="+filelist+"'>"+original+
						"</a><a href='/board/delete_file.do?file_name="+filelist+
						"&idx="+idx+"&cur_page="+cur_page+"&search_option="+search_option+
						"&keyword="+keyword+"'>[삭제]</a><br>";
						
			}			
		
			mav.addObject("html",html);
						
		}	
		
		return mav;
	}
	@Transactional
	@RequestMapping("update.do")
	public String update(BoardDTO dto) throws Exception{
		//boardService.update(dto);
		boardDao.update(dto);
		
//		String[] files=dto.getFiles();
//		if(files==null) return "redirect:/board/list.do";
//		
//		for(String name:files) {
//			boardDao.update_attach(name, dto.getIdx());
//		}
		System.out.println("update.do:"+dto.getFile());
		MultipartFile[] parts=dto.getFile();
		
		//if(parts==null) return "redirect:/board/list.do"; 이거 제대로 판별 못한다.
		
		
		for(MultipartFile part: parts) {
			
			if(part.isEmpty()) return "redirect:/board/list.do"; //이게 문제였다. 이걸로 체크 해야 uuid로 더미 파일이 안나옴
			
			String str= UploadFileUtils.uploadFile(upload_path, part.getOriginalFilename(), part.getBytes());
			
			boardDao.update_attach(str, dto.getIdx());
		}
		
		return "redirect:/board/list.do";
	}
	
	@Transactional
	@RequestMapping("delete.do")
	public String delete(int idx) {
		boardDao.delete(idx);
		List<String> file_names=boardDao.file_detail(idx);
		boardDao.delete_attach_idx(idx);
		
		if(file_names!=null) {
		for(String file_name : file_names) {
		new File(file_name.replace("/", File.separator)).delete();	
		}
		}
		return "redirect:/board/list.do";
		
	}
	
	@GetMapping("delete_file.do")
	public String delete_file(String file_name, int idx,int cur_page, 
			String search_option, String keyword, Model model) {
		System.out.println("delete_file.do:"+file_name);
		boardDao.delete_attach(file_name);
		new File(file_name.replace("/", File.separator)).delete();
		
		//forward 는 페이지로 가는 거다... 
		return "redirect:/board/detail.do?idx="+idx+"&cur_page="+cur_page+"&search_option="+search_option+
				"&keyword="+keyword;
	}
	
	
	@RequestMapping("list_attach/{idx}")
	@ResponseBody
	public List<String> list_attach(@PathVariable("idx") int idx){
		
		
		List<String> list=boardDao.list_attach(idx);
		
		
		return  list;
	}
	
	
	@GetMapping("/download")
	public void download(HttpServletRequest request,HttpServletResponse response, String file_name) throws Exception{
		
		String path=file_name;
		
		String filename=file_name.substring(file_name.indexOf("_")+1);
		
	
		
		response.setHeader("Content-Disposition", "attachment; filename=\""+filename+"\"");
		response.setHeader("ContentType", MediaType.APPLICATION_OCTET_STREAM_VALUE);
		
		FileInputStream fis= new FileInputStream(path);
		OutputStream os= response.getOutputStream();
		
		int read=0;
		byte[] buffer = new byte[1024];
		while((read=fis.read(buffer))!=-1) {
			os.write(buffer,0,read);
		}
		
		fis.close();
		os.close();
		
	}
	
	@RequestMapping("write.test")
	public String writetest() {
		return "include/test";
	}
	
//	@ResponseBody
//	@RequestMapping("/upload/display_file")
//	public ResponseEntity<byte[]> display_file(String file_name) throws Exception{
//		InputStream in = null;
//		ResponseEntity<byte[]> entity = null;
//		try {
//			HttpHeaders headers=new HttpHeaders();
//			in = new FileInputStream(file_name);
//			file_name=file_name.substring(file_name.indexOf("_")+1);
//			headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
//			headers.add("Content-Disposition", "attachment; filename=\""+file_name+"\"");
//			entity= new ResponseEntity<byte[]>(IOUtils.toByteArray(in),headers, HttpStatus.OK);
//		}catch(Exception e) {
//			e.printStackTrace();
//			entity=new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
//		}finally {
//			if(in!=null)
//				in.close();
//		}
//		return entity;
//	}
	
//	@ResponseBody
//	@RequestMapping(value="/upload/delete_file", method=RequestMethod.POST)
//	public ResponseEntity<String> delete_file(String file_name){
//		
//		new File(file_name.replace("/", File.separator)).delete();
//		boardDao.delete_attach(file_name);
//		return new ResponseEntity<String>("deleted",HttpStatus.OK);
//	}

}
