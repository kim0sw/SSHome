/*
 * Copyright 2008-2009 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package egovframework.ssic.ssh.web;

import java.util.List;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import egovframework.ssic.ssh.service.MainService;
import egovframework.ssic.ssh.service.SampleDefaultVO;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

/**
 * @file Name : MainController.java
 * @Description : MainController Class
 * @author swkim
 * @since 2020.03.25
 * @version 1.0
 * @see <pre>
 *  == 개정이력(Modification Information) ==
 *          수정일		수정자			수정내용
 *  ----------------------------------------------------------------
 *   2020.03.25	swkim		최초수정
 * </pre>
 */

@Controller
public class MainController {
	/** MainService */
	@Resource(name = "mainService")
	private MainService mainService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	
	/**
	 * Main 화면을 조회한다.
	 * @param EgovMap - 조회할 정보가 담긴 EgovMap
	 * @param model
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping(value = "/selectMain.do")
	public String selectMain(@ModelAttribute("searchVO") SampleDefaultVO searchVO, ModelMap model) throws Exception {
		EgovMap paramMap = new EgovMap();
		
		// 사업실적 SELECT 년도를 조회
		List<EgovMap> bsnsYearList = mainService.selectBsnsRstYear();
		model.addAttribute("bsnsYearList", bsnsYearList);
		
		// 사업실적 목록을 조회
		List<EgovMap> bsnsRstList = mainService.selectBsnsRstList(paramMap);
		model.addAttribute("bsnsRstList", bsnsRstList);
		
		// 화면 SectionIndex
		model.addAttribute("sectionIndex", searchVO.getSectionIndex());
		
		return "ssh/main";
	}

	/**
	 * 사업실적 목록를 조회한다.
	 * @param EgovMap - 조회할 정보가 담긴 EgovMap
	 * @param model
	 * @return ModelAndView
	 * @exception Exception
	 */
	@RequestMapping(value = "/selectBsnsRstList.do")
	public ModelAndView selectBsnsRstList(@RequestParam("params") String[] params) throws Exception {
		ModelAndView mav = new ModelAndView("jsonView");
		
		EgovMap paramMap = new EgovMap();
		paramMap.put("bYear", params[0]);
		
		// 사업실적 목록 조회
		List<EgovMap> result = mainService.selectBsnsRstList(paramMap);
		
		mav.addObject("result", result);
		
		return mav;
	}

	/**
	 * 사업실적 상세정보를 조회한다.
	 * @param EgovMap - 조회할 정보가 담긴 EgovMap
	 * @param model
	 * @return ModelAndView
	 * @exception Exception
	 */
	@RequestMapping(value = "/selectBsnsRstDetail.do")
	public ModelAndView selectBsnsRstDetail(@RequestParam("params") String[] params) throws Exception {
		ModelAndView mav = new ModelAndView("jsonView");
		
		EgovMap paramMap = new EgovMap();
		paramMap.put("bsnsId", params[0]);
		
		// 사업실적 상세정보 조회
		EgovMap result = mainService.selectBsnsRstDetail(paramMap);
		
		mav.addObject("result", result);
		
		return mav;
	}

	/**
	 * Business 화면을 조회한다.
	 * @param EgovMap - 조회할 정보가 담긴 EgovMap
	 * @param model
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping(value = "/selectBusiness.do")
	public String selectBusiness(@ModelAttribute("searchVO") SampleDefaultVO searchVO, ModelMap model) throws Exception {
		// 화면 SectionIndex
		model.addAttribute("sectionIndex", searchVO.getSectionIndex());
		
		return "ssh/business";
	}

	/**
	 * Board 화면을 조회한다. (pageing)
	 * @param EgovMap - 조회할 정보가 담긴 EgovMap
	 * @param model
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping(value = "/selectBoardList.do")
	public String selectBoardList(@RequestParam("params") String[] params, ModelMap model) throws Exception {
		EgovMap paramMap = new EgovMap();
		
		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(Integer.parseInt(params[0]));
		paginationInfo.setRecordCountPerPage(propertiesService.getInt("pageUnit"));
		paginationInfo.setPageSize(propertiesService.getInt("pageSize"));
		
		// 파라미터
		paramMap.put("firstIndex", paginationInfo.getFirstRecordIndex());							// 페이징 SQL의 조건절에 사용되는 시작 rownum
		paramMap.put("lastIndex", paginationInfo.getLastRecordIndex());							// 페이징 SQL의 조건절에 사용되는 마지막 rownum	
		paramMap.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());	// 한 페이지당 게시되는 게시물 건 수

		paramMap.put("boardId", params[1]);				// 게시판 구분
		paramMap.put("boardCondition", params[2]);	// 게시판 Condition	
		paramMap.put("boardKeyword", params[3]);	// 게시판 Keyword
		
		// 게시판 목록을 조회
		List<EgovMap> boardList = mainService.selectBoardList(paramMap);
		model.addAttribute("boardList", boardList);
		
		// 게시판 paginationInfo
		int totCnt = mainService.selectBoardListTotCnt(paramMap);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "ssh/board";
	}

	/**
	 * 게시판 상세정보를 조회한다.
	 * @param EgovMap - 조회할 정보가 담긴 EgovMap
	 * @param model
	 * @return ModelAndView
	 * @exception Exception
	 */
	@RequestMapping(value = "/selectBoardDetail.do")
	public ModelAndView selectBoardDetail(@RequestParam("params") String[] params) throws Exception {
		ModelAndView mav = new ModelAndView("jsonView");
		
		EgovMap paramMap = new EgovMap();
		paramMap.put("boardId", params[0]);
		paramMap.put("boardNo", params[1]);
		
		// 게시판 상세정보 조회
		EgovMap result = mainService.selectBoardDetail(paramMap);
		
		mav.addObject("result", result);
		
		return mav;
	}

	/**
	 * 게시판 상세정보를 저장한다.
	 * @param EgovMap - 조회할 정보가 담긴 EgovMap
	 * @param model
	 * @return ModelAndView
	 * @exception Exception
	 */
	@RequestMapping(value = "/saveBoardDetail.do")
	public ModelAndView saveBoardDetail(@RequestParam("params") String[] params) throws Exception {
		ModelAndView mav = new ModelAndView("jsonView");
		
		System.out.println(params[0] + " / " + params[1] + " / " + params[2]);
		
		EgovMap paramMap = new EgovMap();
		paramMap.put("boardId", params[0]);
		paramMap.put("boardNo", params[1]);
		paramMap.put("boardTitle", params[2]);
		paramMap.put("boardUser", params[3]);
		paramMap.put("boardPw", params[4]);
		paramMap.put("boardContent", params[5]);
		
		// 게시판 상세정보 저장
		if ("".equals(paramMap.get("boardNo")) || paramMap.get("boardNo") == null) {
			mainService.insertBoardDetail(paramMap);
		} else {
			mainService.updateBoardDetail(paramMap);
		}
		
		mav.addObject("result", "success");
		
		return mav;
	}

}
