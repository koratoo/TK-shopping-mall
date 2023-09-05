package org.innobl.service;

import java.util.List;

import org.innobl.domain.vo.Criteria;
import org.innobl.domain.vo.ReplyVO;

public interface ReplyService {

	public int register(ReplyVO vo);
	public ReplyVO get(String rno);
	public int remove(String rno);
	public int modify(ReplyVO reply);
	public List<ReplyVO> getList(Criteria cri,String PRDCTNO);
}
