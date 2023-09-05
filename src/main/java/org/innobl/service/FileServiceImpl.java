package org.innobl.service;

import java.io.File;
import java.util.UUID;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class FileServiceImpl implements FileService{

    private static final String UPLOAD_FOLDER = "C:\\Users\\-\\Desktop\\innoblife\\innobl2\\src\\main\\webapp\\resources\\img";

    @Override
    public String storeFile(MultipartFile file) {
        String originalFileName = file.getOriginalFilename();
        String extension = "";

        int dotIndex = originalFileName.lastIndexOf('.');
        if (dotIndex > 0) {
            extension = originalFileName.substring(dotIndex);
            originalFileName = originalFileName.substring(0, dotIndex);
        }

        String uniqueFileName = UUID.randomUUID().toString() + extension;

        File saveFile = new File(UPLOAD_FOLDER, uniqueFileName);

        try {
            file.transferTo(saveFile);
            return UPLOAD_FOLDER + "\\" + uniqueFileName;
         } catch (Exception e) {
             throw new RuntimeException("Could not store the file. Error: " + e.getMessage());
         }
    }

}
