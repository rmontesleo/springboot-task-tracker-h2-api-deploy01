package com.demo.task.tracker.controllers;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.demo.task.tracker.models.Task;
import com.demo.task.tracker.services.TaskService;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/tasks")
@AllArgsConstructor
@Slf4j
public class TaskController {

    private final TaskService taskService;

    @GetMapping()
    public ResponseEntity<List<Task>> getAllTask(){
        log.debug("### Returning all task...");
        return  ResponseEntity.ok( taskService.getAllTask() );
    }

    @PostMapping()
    public ResponseEntity<Task> postTask(  @RequestBody Task newTask ){
        log.debug("New task is {}", newTask);
        return ResponseEntity
                .status(HttpStatus.CREATED)
                .body( taskService.saveTask(newTask)  );
    }


    @GetMapping("/{id}")
    public ResponseEntity<Task> getTaskById( @PathVariable Long id ){
        log.debug("Try to Find task {}", id );
        return taskService.findTaskById(id)
                    .map( task -> ResponseEntity.ok(task) )
                    .orElse( ResponseEntity.status(HttpStatus.NOT_FOUND).build() );
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteTask( @PathVariable Long id ){
        log.debug("Trying to delete task {}", id);
        if(  taskService.deleteTask(id) ){
            log.debug("Task with id {} , was delted", id);
            return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
        }
        log.debug("Task with id {} , not found", id);
        return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
    }


    @PutMapping( "/{id}" )
    public ResponseEntity<Task> putTask( 
        @PathVariable Long id, 
        @RequestBody Task updatedTask ){
            log.debug("Updating task with id {} and values {}",  id, updatedTask );
            
            return taskService.updateTask(id, updatedTask)
                        .map( task -> ResponseEntity.ok(task) )
                        .orElse( ResponseEntity.notFound().build() );
    }


    @GetMapping("/fail")
    public ResponseEntity<Void> failByGet() throws Exception{ 
        log.debug("Its goint to fail");       
        throw new Exception("Fail");                
    }
    
}
