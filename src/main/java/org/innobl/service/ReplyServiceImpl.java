package org.innobl.service;

import java.util.List;

import org.innobl.domain.vo.Criteria;
import org.innobl.domain.vo.ReplyVO;
import org.innobl.mapper.ReplyMapper;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ReplyServiceImpl implements ReplyService{

	private final ReplyMapper replyMapper;
	
	@Override
	public int register(ReplyVO vo) {
		return replyMapper.insert(vo);
	}

	@Override
	public ReplyVO get(String rno) {
		return replyMapper.read(rno);
	}

	@Override
	public int remove(String rno) {
		return replyMapper.delete(rno);
	}

	@Override
	public int modify(ReplyVO reply) {
		return replyMapper.update(reply);
	}

	@Override
	public List<ReplyVO> getList(Criteria cri, String PRDCTNO) {
		return replyMapper.getListWithPaging(cri, PRDCTNO);
	}

	@Override
	public List<ReplyVO> getLv1Repl(String rno) {
		return replyMapper.getLv1Repl(rno);
	}

}
