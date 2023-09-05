package org.innobl.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.innobl.domain.vo.Criteria;
import org.innobl.domain.vo.ReplyVO;

public interface ReplyMapper {

	public int insert(ReplyVO vo);
	public ReplyVO read(String rno);
	public int delete(String rno);
	public int update(ReplyVO reply);
	public List<ReplyVO> getListWithPaging(
			@Param("cri") Criteria cri,
			@Param("PRDCTNO") String PRDCTNO);
			
}
