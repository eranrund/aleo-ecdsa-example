// The 'test_ecdsa_example' test program.
import ecdsa_example.aleo;
program test_ecdsa_example.aleo {
    @test
    script test_it() {
        let result: u32 = ecdsa_example.aleo/main(1u32, 2u32);
        assert_eq(result, 3u32);
    }

    @test
    @should_fail
    transition do_nothing() {
        let result: u32 = ecdsa_example.aleo/main(2u32, 3u32);
        assert_eq(result, 3u32);
    }

    @noupgrade
    async constructor() {}
}
