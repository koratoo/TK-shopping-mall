package org.innobl.controller;

import java.util.List;

import org.innobl.domain.vo.Criteria;
import org.innobl.domain.vo.ReplyVO;
import org.innobl.service.ReplyService;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping("/replies")
@RestController
@Log4j
@AllArgsConstructor
public class ReplyController {

	private ReplyService replyService;
	
	@PostMapping(value="/new",
			consumes = "application/json",
			produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody ReplyVO vo){
		log.info("ReplyVO: "+vo);
		int insertCount = replyService.register(vo);
		return insertCount == 1	
				? new ResponseEntity<>("success",HttpStatus.OK)	
				:new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value = "/pages/{prdctno}/{page}",
			produces = {MediaType.APPLICATION_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<List<ReplyVO>> getList(@PathVariable("page") int page, @PathVariable("prdctno")String PRDCTNO){
		Criteria cri = new Criteria(page,10);
		return new ResponseEntity<>(replyService.getList(cri,PRDCTNO),HttpStatus.OK);
	}
	
	@GetMapping("/rno")
	public ResponseEntity<ReplyVO> get(@PathVariable("rno")String rno){
		return new ResponseEntity<>(replyService.get(rno),HttpStatus.OK);
	}
	
	@DeleteMapping("rno")
	public ResponseEntity<String> remove(@PathVariable("rno")String rno){
		return replyService.remove(rno) == 1
				? new ResponseEntity<>("success",HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH},
		value="/{rno}",
		consumes = "applicatoin/json",
		produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> modify(
			@RequestBody ReplyVO vo,
			@PathVariable("rno") String rno){
		
		vo.setRNO(rno);
		log.info("rno : "+ rno);
		
		return replyService.modify(vo) == 1
				? new ResponseEntity<>("success",HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value = "/show/{rno}" ,
			produces = {MediaType.APPLICATION_XML_VALUE,
			MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<List<ReplyVO>> getLv1Replyshow(@PathVariable String rno){
		
		return new ResponseEntity<>(replyService.getLv1Repl(rno),HttpStatus.OK);
	}
}
