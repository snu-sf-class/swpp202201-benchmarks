; ModuleID = '/tmp/a.ll'
source_filename = "anagram/src/anagram.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define dso_local i32 @count(i8 zeroext %val, i64 %len, i8* %str) #0 {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %count.0 = phi i32 [ 0, %entry ], [ %count.1, %for.inc ]
  %i.0 = phi i32 [ 0, %entry ], [ %inc6, %for.inc ]
  %conv = sext i32 %i.0 to i64
  %cmp = icmp ult i64 %conv, %len
  br i1 %cmp, label %for.body, label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.cond
  br label %for.end

for.body:                                         ; preds = %for.cond
  %conv2 = zext i8 %val to i32
  %idxprom = sext i32 %i.0 to i64
  %arrayidx = getelementptr inbounds i8, i8* %str, i64 %idxprom
  %0 = load i8, i8* %arrayidx, align 1
  %conv3 = zext i8 %0 to i32
  %cmp4 = icmp eq i32 %conv2, %conv3
  br i1 %cmp4, label %if.then, label %if.end

if.then:                                          ; preds = %for.body
  %inc = add nsw i32 %count.0, 1
  br label %if.end

if.end:                                           ; preds = %if.then, %for.body
  %count.1 = phi i32 [ %inc, %if.then ], [ %count.0, %for.body ]
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %inc6 = add nsw i32 %i.0, 1
  br label %for.cond, !llvm.loop !2

for.end:                                          ; preds = %for.cond.cleanup
  ret i32 %count.0
}

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: nounwind uwtable
define dso_local i32 @anagram(i64 %len, i8* %str1, i8* %str2) #0 {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %val.0 = phi i8 [ 0, %entry ], [ %inc, %for.inc ]
  %retval.0 = phi i32 [ 0, %entry ], [ %retval.1, %for.inc ]
  %conv = zext i8 %val.0 to i32
  %cmp = icmp slt i32 %conv, 255
  br i1 %cmp, label %for.body, label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.cond
  br label %cleanup6

for.body:                                         ; preds = %for.cond
  %call = call i32 @count(i8 zeroext %val.0, i64 %len, i8* %str1)
  %call2 = call i32 @count(i8 zeroext %val.0, i64 %len, i8* %str2)
  %cmp3 = icmp ne i32 %call, %call2
  br i1 %cmp3, label %if.then, label %if.end

if.then:                                          ; preds = %for.body
  br label %cleanup

if.end:                                           ; preds = %for.body
  br label %cleanup

cleanup:                                          ; preds = %if.end, %if.then
  %cleanup.dest.slot.0 = phi i32 [ 1, %if.then ], [ 0, %if.end ]
  %retval.1 = phi i32 [ 0, %if.then ], [ %retval.0, %if.end ]
  switch i32 %cleanup.dest.slot.0, label %cleanup6 [
    i32 0, label %cleanup.cont
  ]

cleanup.cont:                                     ; preds = %cleanup
  br label %for.inc

for.inc:                                          ; preds = %cleanup.cont
  %inc = add i8 %val.0, 1
  br label %for.cond, !llvm.loop !5

cleanup6:                                         ; preds = %cleanup, %for.cond.cleanup
  %cleanup.dest.slot.1 = phi i32 [ %cleanup.dest.slot.0, %cleanup ], [ 2, %for.cond.cleanup ]
  %retval.2 = phi i32 [ %retval.1, %cleanup ], [ %retval.0, %for.cond.cleanup ]
  switch i32 %cleanup.dest.slot.1, label %unreachable [
    i32 2, label %for.end
    i32 1, label %return
  ]

for.end:                                          ; preds = %cleanup6
  br label %return

return:                                           ; preds = %for.end, %cleanup6
  %retval.3 = phi i32 [ %retval.2, %cleanup6 ], [ 1, %for.end ]
  ret i32 %retval.3

unreachable:                                      ; preds = %cleanup6
  ret i32 0
}

; Function Attrs: nounwind uwtable
define dso_local i32 @main() #0 {
entry:
  %call = call i64 (...) @read()
  %cmp = icmp eq i64 %call, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  br label %cleanup

if.end:                                           ; preds = %entry
  %add = add i64 %call, 7
  %div = udiv i64 %add, 8
  %mul = mul i64 %div, 8
  %mul1 = mul i64 %mul, 1
  %call2 = call noalias i8* @malloc(i64 %mul1) #4
  %add3 = add i64 %call, 7
  %div4 = udiv i64 %add3, 8
  %mul5 = mul i64 %div4, 8
  %mul6 = mul i64 %mul5, 1
  %call7 = call noalias i8* @malloc(i64 %mul6) #4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %if.end
  %i.0 = phi i32 [ 0, %if.end ], [ %inc, %for.inc ]
  %conv = sext i32 %i.0 to i64
  %cmp8 = icmp ult i64 %conv, %call
  br i1 %cmp8, label %for.body, label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.cond
  br label %for.end

for.body:                                         ; preds = %for.cond
  %call10 = call i64 (...) @read()
  %rem = urem i64 %call10, 256
  %conv11 = trunc i64 %rem to i8
  %idxprom = sext i32 %i.0 to i64
  %arrayidx = getelementptr inbounds i8, i8* %call2, i64 %idxprom
  store i8 %conv11, i8* %arrayidx, align 1
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %inc = add nsw i32 %i.0, 1
  br label %for.cond, !llvm.loop !6

for.end:                                          ; preds = %for.cond.cleanup
  br label %for.cond13

for.cond13:                                       ; preds = %for.inc24, %for.end
  %i12.0 = phi i32 [ 0, %for.end ], [ %inc25, %for.inc24 ]
  %conv14 = sext i32 %i12.0 to i64
  %cmp15 = icmp ult i64 %conv14, %call
  br i1 %cmp15, label %for.body18, label %for.cond.cleanup17

for.cond.cleanup17:                               ; preds = %for.cond13
  br label %for.end26

for.body18:                                       ; preds = %for.cond13
  %call19 = call i64 (...) @read()
  %rem20 = urem i64 %call19, 256
  %conv21 = trunc i64 %rem20 to i8
  %idxprom22 = sext i32 %i12.0 to i64
  %arrayidx23 = getelementptr inbounds i8, i8* %call7, i64 %idxprom22
  store i8 %conv21, i8* %arrayidx23, align 1
  br label %for.inc24

for.inc24:                                        ; preds = %for.body18
  %inc25 = add nsw i32 %i12.0, 1
  br label %for.cond13, !llvm.loop !7

for.end26:                                        ; preds = %for.cond.cleanup17
  %call27 = call i32 @anagram(i64 %call, i8* %call2, i8* %call7)
  %conv28 = sext i32 %call27 to i64
  call void @write(i64 %conv28)
  br label %cleanup

cleanup:                                          ; preds = %for.end26, %if.then
  ret i32 0
}

declare dso_local i64 @read(...) #2

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #3

declare dso_local void @write(i64) #2

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nofree nosync nounwind willreturn }
attributes #2 = { "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 12.0.1 (https://github.com/llvm/llvm-project.git 072c90a863aac1334a4950b3da262a025516dea0)"}
!2 = distinct !{!2, !3, !4}
!3 = !{!"llvm.loop.mustprogress"}
!4 = !{!"llvm.loop.unroll.disable"}
!5 = distinct !{!5, !3, !4}
!6 = distinct !{!6, !3, !4}
!7 = distinct !{!7, !3, !4}
