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
package egovframework.ssic.ssh.service.impl;

import java.util.List;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.ssic.ssh.service.MainService;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

/**
 * @file Name : MainServiceImpl.java
 * @Description : Main Business Implement Class
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

@Service("mainService")
public class MainServiceImpl extends EgovAbstractServiceImpl implements MainService {
	@SuppressWarnings("unused")
	private static final Logger LOGGER = LoggerFactory.getLogger(MainServiceImpl.class);

	// TODO ibatis 사용
//	@Resource(name="mainDAO")
//	private MainDAO mainDAO;
	// TODO mybatis 사용
	@Resource(name="mainMapper")
	private MainMapper mainMapper;

	/**
	 * 사업실적 SELECT 년도를 조회한다.
	 * @param 
	 * @return List<EgovMap> - 년도 목록
	 * @exception Exception
	 */
	@Override
	public List<EgovMap> selectBsnsRstYear() throws Exception {
		return mainMapper.selectBsnsRstYear();
	}

	/**
	 * 사업실적 목록을 조회한다.
	 * @param pramMap - 조회할 정보가 담긴 EgovMap
	 * @return List<EgovMap> - 사업실적 목록
	 * @exception Exception
	 */
	@Override
	public List<EgovMap> selectBsnsRstList(EgovMap pramMap) throws Exception {
		return mainMapper.selectBsnsRstList(pramMap);
	}

	/**
	 * 사업실적 상세정보를 조회한다.
	 * @param pramMap - 조회할 정보가 담긴 EgovMap
	 * @return EgovMap - 사업실적 상세정보
	 * @exception Exception
	 */
	@Override
	public EgovMap selectBsnsRstDetail(EgovMap pramMap) throws Exception {
		return mainMapper.selectBsnsRstDetail(pramMap);
	}

	/**
	 * 게시판 목록을 조회한다.
	 * @param pramMap - 조회할 정보가 담긴 EgovMap
	 * @return List<EgovMap> - 게시판 목록
	 * @exception Exception
	 */
	@Override
	public List<EgovMap> selectBoardList(EgovMap pramMap) throws Exception {
		return mainMapper.selectBoardList(pramMap);
	}

	/**
	 * 게시판 목록 갯수를 조회한다.
	 * @param pramMap - 조회할 정보가 담긴 EgovMap
	 * @return int - 게시판 목록 갯수
	 * @exception Exception
	 */
	@Override
	public int selectBoardListTotCnt(EgovMap pramMap) throws Exception {
		return mainMapper.selectBoardListTotCnt(pramMap);
	}

	/**
	 * 게시판 상세정보를 조회한다.
	 * @param pramMap - 조회할 정보가 담긴 EgovMap
	 * @return EgovMap - 게시판 상세정보
	 * @exception Exception
	 */
	@Override
	public EgovMap selectBoardDetail(EgovMap pramMap) throws Exception {
		return mainMapper.selectBoardDetail(pramMap);
	}

	/**
	 * 게시판 상세정보를 저장한다.
	 * @param pramMap - 조회할 정보가 담긴 EgovMap
	 * @return 
	 * @exception Exception
	 */
	@Override
	public void insertBoardDetail(EgovMap pramMap) throws Exception {
		mainMapper.insertBoardDetail(pramMap);
	}

	/**
	 * 게시판 상세정보를 저장한다.
	 * @param pramMap - 조회할 정보가 담긴 EgovMap
	 * @return 
	 * @exception Exception
	 */
	@Override
	public void updateBoardDetail(EgovMap pramMap) throws Exception {
		mainMapper.updateBoardDetail(pramMap);
	}

}
