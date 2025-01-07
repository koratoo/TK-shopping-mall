### Spring Boot ReplyController 클래스 설명

이번 글에서는 Spring Boot 기반으로 작성된 `ReplyController` 클래스의 구조와 기능에 대해 알아보겠습니다. 
이 클래스는 댓글(Reply) 관리 기능을 담당하며, RESTful API를 통해 다양한 작업을 수행합니다.

---

#### 1. **클래스 개요**
`ReplyController`는 댓글 데이터를 처리하기 위한 REST 컨트롤러입니다. Spring Boot의 `@RestController`와 관련 어노테이션을 활용하여 간결하면서도 강력한 REST API를 제공합니다. 주요 기능으로는 댓글 생성, 조회, 수정, 삭제 등이 있습니다.

---

#### 2. **주요 어노테이션**
- `@RestController`: 해당 클래스가 RESTful 웹 서비스를 제공한다는 것을 명시.
- `@RequestMapping("/replies")`: `/replies` 경로로 들어오는 요청을 이 컨트롤러에서 처리.
- `@Log4j`: 로깅을 위해 Log4j를 사용.
- `@AllArgsConstructor`: 생성자를 자동으로 생성하여 의존성을 주입.

---

#### 3. **주요 메서드 설명**

##### 3.1 댓글 생성 - `create()`
```java
@PostMapping(value="/new", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
public ResponseEntity<String> create(@RequestBody ReplyVO vo)
```
- **HTTP Method**: POST
- **경로**: `/replies/new`
- **기능**: 댓글을 생성.
- **입력**: `ReplyVO`(JSON 형식).
- **출력**: 성공 시 `"success"`, 실패 시 500 에러 반환.

##### 3.2 댓글 목록 조회 - `getList()`
```java
@GetMapping(value = "/pages/{prdctno}/{page}", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
public ResponseEntity<List<ReplyVO>> getList(@PathVariable("page") int page, @PathVariable("prdctno") String PRDCTNO)
```
- **HTTP Method**: GET
- **경로**: `/replies/pages/{prdctno}/{page}`
- **기능**: 특정 제품(`prdctno`)의 댓글 목록을 페이지 단위로 조회.
- **입력**: `prdctno`와 `page`를 URL에서 추출.
- **출력**: 댓글 리스트(JSON 또는 XML 형식).

##### 3.3 댓글 단건 조회 - `get()`
```java
@GetMapping("/rno")
public ResponseEntity<ReplyVO> get(@PathVariable("rno") String rno)
```
- **HTTP Method**: GET
- **경로**: `/replies/rno`
- **기능**: 특정 댓글 번호(`rno`)에 해당하는 댓글 조회.
- **출력**: 댓글 데이터(JSON 형식).

##### 3.4 댓글 삭제 - `remove()`
```java
@DeleteMapping("rno")
public ResponseEntity<String> remove(@PathVariable("rno") String rno)
```
- **HTTP Method**: DELETE
- **경로**: `/replies/rno`
- **기능**: 특정 댓글 삭제.
- **출력**: 성공 시 `"success"`, 실패 시 500 에러 반환.

##### 3.5 댓글 수정 - `modify()`
```java
@RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH}, value="/{rno}", consumes = "application/json", produces = { MediaType.TEXT_PLAIN_VALUE })
public ResponseEntity<String> modify(@RequestBody ReplyVO vo, @PathVariable("rno") String rno)
```
- **HTTP Method**: PUT/PATCH
- **경로**: `/replies/{rno}`
- **기능**: 특정 댓글 수정.
- **입력**: 수정할 댓글 데이터를 JSON 형식으로 전달.
- **출력**: 성공 시 `"success"`, 실패 시 500 에러 반환.

##### 3.6 대댓글 조회 - `getLv1Replyshow()`
```java
@GetMapping(value = "/show/{rno}", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
public ResponseEntity<List<ReplyVO>> getLv1Replyshow(@PathVariable String rno)
```
- **HTTP Method**: GET
- **경로**: `/replies/show/{rno}`
- **기능**: 특정 댓글(`rno`)의 대댓글(Level 1)을 조회.
- **출력**: 대댓글 리스트.

---

#### 4. **서비스 계층과 연동**
`ReplyController`는 `ReplyService`를 통해 비즈니스 로직을 처리합니다. 서비스 계층에서 데이터베이스 접근 및 처리 과정을 분리함으로써 응집도를 높이고 테스트 가능성을 향상시킵니다.

---

#### 5. **에러 처리**
`ResponseEntity`를 활용하여 API 요청 처리 결과에 따라 적절한 HTTP 상태 코드를 반환합니다:
- 성공: `HttpStatus.OK`
- 실패: `HttpStatus.INTERNAL_SERVER_ERROR`

---

#### 6. **확장 가능성**
이 컨트롤러는 구조가 잘 설계되어 추가적인 기능을 손쉽게 확장할 수 있습니다. 예를 들어, 댓글 좋아요 기능이나 신고 기능을 추가할 수 있습니다.

-----------

```java


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
```
